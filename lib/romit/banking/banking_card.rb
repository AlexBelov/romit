require 'romit/base'

module Romit
  class BankingCard < Base
    def get(id)
      resp = Client.request(:get, "/banking/card/#{id}", {}, @member_account.access_token)
      resp_body = Utils.handle_response(resp)
      BankingCard.new(
        @member_account,
        {
          id: resp_body[:id],
          name: resp_body[:name],
          number: resp_body[:number],
          expiration: resp_body[:expiration],
          type: Utils.parse_enum(resp_body[:type]),
          status: Utils.parse_enum(resp_body[:status]),
          created_at: Utils.parse_epoch(resp_body[:created])
        }
      )
    end

    def create(opts = {})
      resp = Client.request(:post, "/banking/card", opts, @member_account.access_token)
      resp_body = Utils.handle_response(resp)
      BankingItem.new(
        id: resp_body[:id]
      )
    end

    def delete(id = nil)
      resp = Client.request(:delete, "/banking/card/#{id || @values[:id]}", {}, @member_account.access_token)
      Utils.handle_response(resp)
      true
    end
  end
end
