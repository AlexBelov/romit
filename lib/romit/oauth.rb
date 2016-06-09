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
      resp_body = Romit::Utils.handle_response(resp)

      Romit::Token.new(
        type: :client_token,
        token: resp_body[:access_token],
        expires: Romit::Utils.parse_timestamp(resp_body[:access_token_expires])
      )
    end

    def self.request_user_authorization_link(redirect_uri, scopes, state)
      scopes = 'DEFAULT|BANKING_READ|BANKING_WRITE|IDENTITY_READ|IDENTITY_WRITE|TRANSFER_READ|TRANSFER_WRITE|USER_READ|USER_WRITE'
      auth_url = Romit.api_base.include?('sandbox') ? 'auth.sandbox.romit.io' : 'auth.romit.io'
      "https://#{auth_url}/#/app/authorize?client_id=#{Romit.client_id}&response_type=code&redirect_uri=#{redirect_uri}&scope=#{scopes}&state=#{state}"
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

      self.return_token(resp_body)
    end

    def self.refresh_authorization(refresh_token)
      params = {
        client_id: Romit.client_id,
        client_secret: Romit.client_secret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token',
      }
      resp = Client.request(:post, '/oauth/token', params)
      resp_body = Utils.handle_response(resp)

      self.return_token(resp_body)
    end

    def self.return_token(resp_body)
      {
        access_token: Romit::Token.new(
          type: :access_token,
          token: resp_body[:access_token],
          expires: Utils.parse_timestamp(resp_body[:access_token_expires])
        ),
        refresh_token: Romit::Token.new(
          type: :refresh_token,
          token: resp_body[:refresh_token],
          expires: Utils.parse_timestamp(resp_body[:refresh_token_expires])
        )
      }
    end
  end
end
