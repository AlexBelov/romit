module Romit
  class User < Base
    def self.types
      %i(individual business)
    end

    def self.statuses
      %i(not_submitted submitted approved denied)
    end

    def self.retrieve
      resp = Client.request(:get, "/user", {}, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      self.new(
        id: resp_body[:id],
        phone: resp_body[:phone],
        email: resp_body[:email],
        first_name: resp_body[:first],
        last_name: resp_body[:last],
        type: Utils.parse_enum(resp_body[:type]),
        status: Utils.parse_enum(resp_body[:status]),
        level: resp_body[:level],
        created_at: Utils.parse_epoch(resp_body[:created])
      )
    end
  end
end
