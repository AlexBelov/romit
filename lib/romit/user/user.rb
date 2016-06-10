require 'romit/user/user_item'

module Romit
  class User
    def initialize(member_account)
      @member_account = member_account
    end

    def retrieve
      resp = Client.request(:get, '/user', {}, @member_account.access_token)
      resp_body = Utils.handle_response(resp)
      UserItem.new(user_params(resp_body))
    end

    private

    # rubocop:disable MethodLength
    def user_params(resp_body)
      {
        id: resp_body[:id],
        phone: resp_body[:phone],
        email: resp_body[:email],
        first_name: resp_body[:first],
        last_name: resp_body[:last],
        type: Utils.parse_enum(resp_body[:type]),
        status: Utils.parse_enum(resp_body[:status]),
        level: resp_body[:level],
        created_at: Utils.parse_epoch(resp_body[:created])
      }
    end
  end
end
