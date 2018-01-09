require 'jwt'
require 'ruby_adobe_io/http_request'

module AdobeIo
  class Authenticator
    attr_reader :client_secret, :api_key, :ims_host, :expiry_time, :scope

    def initialize(opts)
      @client_secret = opts[:client_secret]
      @api_key = opts[:api_key]
      @ims_host = opts[:ims_host]
      @expiry_time = opts[:expiry_time]
      @private_key = opts[:private_key]
      @scope = opts[:scope] || "ent_activation_sdk"
    end

    def exchange_jwt
      url = "https://#{ims_host}/ims/exchange/jwt"
      headers = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Cache-Control' => 'no-cache'
      }

      AdobeIo.logger.debug body
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
        iss: AdobeIo.iss,
        sub: AdobeIo.sub,
        iat: expiry_time - 10000,
        jti: '1479490921',
        aud: "https://#{ims_host}/c/#{api_key}",
        "https://#{ims_host}/s/#{scope}" => true
      }
    end
  end
end
