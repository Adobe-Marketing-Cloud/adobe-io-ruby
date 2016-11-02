require 'jwt'
require 'adobe_io/version'
require 'adobe_io/http_request'

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

  class Authenticator
    attr_reader :client_secret, :api_key, :ims_host, :expiry_time

    def initialize(opts)
      @client_secret = opts[:client_secret]
      @api_key = opts[:api_key]
      @ims_host = opts[:ims_host]
      @expiry_time = opts[:expiry_time]
    end

    def exchange_jwt
      url = "https://#{ims_host}/ims/exchange/jwt"
      headers = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Cache-Control' => 'no-cache'
      }

      BaseHTTP.post url, body, headers
    end

    def body
      {
        client_id: api_key,
        client_secret: client_secret,
        jwt_token: jwt_token
      }
    end

    def jwt_token
      @jwt_token ||= JWT.encode jwt_payload, rsa_private, 'RS256'
    end

    def rsa_private
      @rsa_private ||= OpenSSL::PKey::RSA.new(File.read('private.key'))
    end

    def jwt_payload
      {
        exp: expiry_time,
        iss: 'C42C917D550828520A4C98A6@AdobeOrg',
        sub: '1F2BF2BD581791B90A495E7B@techacct.adobe.com',
        aud: "https://#{ims_host}/c/#{api_key}",
        "https://#{ims_host}/s/ent_user_sdk" => true
      }
    end
  end
end
