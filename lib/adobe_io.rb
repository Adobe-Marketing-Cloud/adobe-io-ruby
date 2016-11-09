require 'adobe_io/version'
require 'adobe_io/authenticator'

module AdobeIo
  class ReactorSpider
    def start
      exit = false
      links = nil
      while(!exit) do
        puts "Type endpoint or previous link key"
        puts build_links_menu(links) if links
        puts ""
        input = prompt("(q) to exit > ")
        break if exit?(input) || !valid?(input)
        response = get_url "https://#{ENV['REACTOR_HOST']}/#{input}"
        links = parse_links(response)
        pp response
      end
    end

    def build_links_menu(links)
      puts JSON.pretty_generate(links)
    end

    def parse_links(response)
      data = response['data']
      if data.instance_of?(Array)
        res_id = 0
        data.reduce({}) do |memo, res|
          result = { res_id => links_for(res).merge({id: res['id']})}
          res_id += 1
          memo.merge(result)
        end
      else
        links_for(res)
      end
    end

    def links_for(res)
      res['links']
    end

    def valid?(input)
      input && input.length > 0
    end

    def exit?(input)
      %w(exit quit q e).include?(input.downcase)
    end

    def prompt(str)
      print str
      gets.chomp
    end

    def access_token
      @access_token ||= fetch_access_token
    end

    def fetch_access_token
      opts = {
        client_secret: ENV['IO_CLIENT_SECRET'],
        api_key: ENV['IO_API_KEY'],
        ims_host: ENV['IO_IMS_HOST'],
        private_key: ENV['IO_PRIVATE_KEY'],
        expiry_time: Time.now.to_i + (60 * 60 * 24)
      }
      response = Authenticator.new(opts).exchange_jwt

      response['access_token']
    rescue Exception => e
      puts "There was an error with your request: #{e.message}"
      raise e
    end

    def get_url(url)
      headers = {
        "Accept" => "application/vnd.api+json;revision=1",
        "Content-Type" => "application/json",
        "X-Api-Key" => "Activation-DTM",
        "Authorization" => "bearer #{access_token}"
      }

      BaseHTTP.get(url, headers)
    end
  end

  def self.main
    ReactorSpider.new.start
  end
end
