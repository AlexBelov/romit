module Romit
  class PublicUser < Base
    def self.get(phone)
      resp = Client.request(:get, "/user", {}, MemberAccount.access_token)
      resp_body = Romit::Utils.handle_response(resp)
      self.new(
        level: resp_body[:level],
        type: Romit::Utils.parse_enum(resp_body[:type]),
        business_name: resp_body[:businessName]
      )
    end

    def self.create(client_token, opts = {})
      resp = Client.request(:post, "/user", opts, client_token)
      resp_body = Utils.handle_response(resp)
      {
        access_token: Token.new(
          type: :access_token,
          token: resp_body[:access_token],
          expires: Utils.parse_timestamp(resp_body[:access_token_expires])
        ),
        refresh_token: Token.new(
          type: :refresh_token,
          token: resp_body[:refresh_token],
          expires: Utils.parse_timestamp(resp_body[:refresh_token_expires])
        )
      }
    end
  end
end
