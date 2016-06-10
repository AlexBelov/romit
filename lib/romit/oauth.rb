require 'romit/token'

module Romit
  module OAuth
    SANDBOX_AUTH = 'auth.sandbox.romit.io'.freeze
    LIVE_AUTH = 'auth.romit.io'.freeze
    SCOPES = %w(DEFAULT BANKING_READ BANKING_WRITE IDENTITY_READ IDENTITY_WRITE
                TRANSFER_READ TRANSFER_WRITE USER_READ USER_WRITE).freeze

    def self.client_access_token
      params = {
        client_id: Romit.client_id,
        client_secret: Romit.client_secret,
        grant_type: 'client_credentials'
      }
      resp = Client.request(:post, '/oauth/token', params)
      resp_body = Utils.handle_response(resp)
      Utils.handle_token(:access_token, resp_body, true)
    end

    def self.request_user_authorization_link(redirect_uri, scopes, state)
      scopes = SCOPES.join('|') if scopes.empty?
      "https://#{auth_url(Romit.api_base)}/#/app/authorize?"\
      "client_id=#{Romit.client_id}"\
      "&response_type=code&redirect_uri=#{redirect_uri}&scope=#{scopes}"\
      "&state=#{state}"
    end

    def self.finish_user_authorization(redirect_uri, code)
      params = {
        client_id: Romit.client_id,
        client_secret: Romit.client_secret,
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri
      }
      resp = Client.request(:post, '/oauth/token', params)
      resp_body = Utils.handle_response(resp)

      return_token(resp_body)
    end

    def self.refresh_authorization(refresh_token)
      params = {
        client_id: Romit.client_id,
        client_secret: Romit.client_secret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }
      resp = Client.request(:post, '/oauth/token', params)
      resp_body = Utils.handle_response(resp)

      return_token(resp_body)
    end

    def self.return_token(resp_body)
      {
        access_token: Utils.handle_token(:access_token, resp_body),
        refresh_token: Utils.handle_token(:refresh_token, resp_body)
      }
    end

    def self.auth_url(api_base)
      if api_base.include?('sandbox')
        SANDBOX_AUTH
      else
        LIVE_AUTH
      end
    end
  end
end
