module Romit
  class User < Base
    def self.types
      %i(individual business)
    end

    def self.statuses
      %i(not_submitted submitted approved denied)
    end

    def self.retrieve(romit_model)
      resp = Romit.request(:get, '/user', {}, romit_model.current_romit_access_token)
      resp_body = resp[:response]
      self.new(
        id: resp_body[:id],
        phone: resp_body[:phone],
        email: resp_body[:email],
        first_name: resp_body[:first],
        last_name: resp_body[:last],
        type: Romit::Utils.parse_enum(resp_body[:type]),
        status: Romit::Utils.parse_enum(resp_body[:status]),
        level: resp_body[:level],
        created_at: Romit::Utils.parse_epoch(resp_body[:created])
      )
    end
  end
end
