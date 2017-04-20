require 'jwt'
require 'adobe_io/http_request'

module AdobeIo
  class Authenticator
    attr_reader :client_secret, :api_key, :ims_host, :expiry_time

    def initialize(opts)
      @client_secret = opts[:client_secret]
      @api_key = opts[:api_key]
      @ims_host = opts[:ims_host]
      @expiry_time = opts[:expiry_time]
      @private_key = opts[:private_key]
    end

    def exchange_jwt
      url = "https://#{ims_host}/ims/exchange/jwt"
      headers = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Cache-Control' => 'no-cache'
      }

      puts body
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
      @rsa_private ||= OpenSSL::PKey::RSA.new(@private_key)
    end

    def jwt_payload
      {
        exp: expiry_time,
        # iss: 'C42C917D550828520A4C98A6@AdobeOrg',
        # sub: '1F2BF2BD581791B90A495E7B@techacct.adobe.com',
        # iss: '08364A825824E04F0A494115@AdobeOrg',
        # sub: '8A020D375829FEC10A49422C@techacct.adobe.com',
        # sub: '3235A2C7582F3D390A494234@techacct.adobe.com',
        iss: ENV['IO_ISS'],
        sub: ENV['IO_SUB'],
        iat: expiry_time - 10000,
        jti: '1479490921',
        aud: "https://#{ims_host}/c/#{api_key}",
        "https://#{ims_host}/s/ent_user_sdk" => true
      }
    end
  end
end
