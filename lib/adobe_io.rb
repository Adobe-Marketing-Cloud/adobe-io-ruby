require 'adobe_io/version'
require 'adode_io/authenticator'

module AdobeIo
  def self.access_token
    opts = {
      client_secret: ENV['IO_CLIENT_SECRET'],
      api_key: ENV['IO_API_KEY'],
      ims_host: ENV['IO_IMS_HOST'],
      expiry_time: Time.now.to_i + (60 * 60 * 24)
    }
    response = Authenticator.new(opts).exchange_jwt

    response['access_token']
  rescue Exception => e
    puts "There was an error with your request: #{e.message}"
    raise e
  end
end
