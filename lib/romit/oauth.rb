require 'romit/token'

module Romit
  module OAuth
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
      scopes = 'DEFAULT|BANKING_READ|BANKING_WRITE|IDENTITY_READ|\
               IDENTITY_WRITE|TRANSFER_READ|TRANSFER_WRITE|USER_READ|\
               USER_WRITE' if scopes.empty?
      "https://#{auth_url}/#/app/authorize?client_id=#{Romit.client_id}\
      &response_type=code&redirect_uri=#{redirect_uri}&scope=#{scopes}\
      &state=#{state}"
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

    def self.auth_url
      if Romit.api_base.include?('sandbox')
        'auth.sandbox.romit.io'
      else
        'auth.romit.io'
      end
    end
  end
end
