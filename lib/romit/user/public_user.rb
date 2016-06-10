require 'romit/user/user_item'

module Romit
  class PublicUser
    def self.get(client_token, phone)
      resp = Client.request(
        :get, "/user/#{phone}", {}, client_token
      )
      resp_body = Romit::Utils.handle_response(resp)
      UserItem.new(
        level: resp_body[:level],
        type: Romit::Utils.parse_enum(resp_body[:type]),
        business_name: resp_body[:businessName]
      )
    end

    def self.create(client_token, opts = {})
      resp = Client.request(:post, '/user', opts, client_token)
      resp_body = Utils.handle_response(resp)
      {
        access_token: Utils.handle_token(:access_token, resp_body),
        refresh_token: Utils.handle_token(:refresh_token, resp_body)
      }
    end
  end
end
