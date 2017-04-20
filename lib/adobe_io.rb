require 'adobe_io/version'
require 'adobe_io/authenticator'

module AdobeIo
  class AccessToken
    attr_reader :client_secret, :api_key, :ims_host, :private_key

    def initialize(options={})
      # load_config(options['config'])
      @client_secret = ENV['IO_CLIENT_SECRET']
      @api_key = ENV['IO_API_KEY']
      @ims_host = ENV['IO_IMS_HOST']
      @private_key = ENV['IO_PRIVATE_KEY']
    end

    def generate
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
      puts response

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

  def self.generate
    AccessToken.new.generate
  end
end
