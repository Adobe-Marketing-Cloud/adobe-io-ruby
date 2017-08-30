require 'adobe_io/version'
require 'adobe_io/authenticator'
require 'dry-configurable'

module AdobeIo
  extend ::Dry::Configurable

  setting :logger, Logger.new(STDOUT), reader: true
  setting :client_secret, nil, reader: true
  setting :api_key, nil, reader: true
  setting :ims_host, nil, reader: true
  setting :private_key, nil, reader: true
  setting :iss, nil, reader: true
  setting :sub, nil, reader: true

  class AccessToken
    attr_reader :client_secret, :api_key, :ims_host, :private_key

    def generate
      @access_token ||= fetch_access_token
    end

    def fetch_access_token
      opts = {
        client_secret: AdobeIo.client_secret,
        api_key: AdobeIo.api_key,
        ims_host: AdobeIo.ims_host,
        private_key: AdobeIo.private_key,
        expiry_time: Time.now.to_i + (60 * 60 * 24)
      }
      response = Authenticator.new(opts).exchange_jwt
      response['access_token']
    rescue Exception => e
      AdobeIo.logger.info "There was an error with your request: #{e.message}"
      raise e
    end
  end

  def self.generate
    AccessToken.new.generate
  end
end
