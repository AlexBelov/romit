require 'romit/base'

module Romit
  class BankingCard < Base
    def get(id)
      resp = Client.request(
        :get, "/banking/card/#{id}", {}, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      BankingCard.new(@member_account, banking_card_params(resp_body))
    end

    def create(opts = {})
      resp = Client.request(
        :post, '/banking/card', opts, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      BankingItem.new(id: resp_body[:id])
    end

    def delete(id = nil)
      endpoint = "/banking/card/#{id || @values[:id]}"
      resp = Client.request(:delete, endpoint, {}, @member_account.access_token)
      Utils.handle_response(resp)
      true
    end

    private

    def banking_card_params(resp_body)
      {
        id: resp_body[:id],
        name: resp_body[:name],
        number: resp_body[:number],
        expiration: resp_body[:expiration],
        type: Utils.parse_enum(resp_body[:type]),
        status: Utils.parse_enum(resp_body[:status]),
        created_at: Utils.parse_epoch(resp_body[:created])
      }
    end
  end
end
