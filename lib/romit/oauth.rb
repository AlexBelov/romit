require 'romit/token'

module Romit
  module OAuth
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

    # rubocop:disable MethodLength
    def self.request_user_authorization(client_token, params)
      opts = {
        client_id: Romit.client_id,
        response_type: 'code',
        redirect_uri: params[:redirect_uri],
        scope: params[:scopes] || SCOPES,
        state: params[:state],
        phone: params[:phone],
        email: params[:email],
        first: params[:first],
        last: params[:last],
        currency: 'USD',
        refresh: params[:refresh],
        call: params[:call]
      }
      resp = Client.request(:post, '/oauth', opts, client_token)

      Utils.handle_auth_response(resp)
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
  end
end
