require 'romit/banking/banking_item'

module Romit
  class Banking
    def initialize(member_account)
      @member_account = member_account
    end

    def list
      resp = Client.request(:get, '/banking', {}, @member_account.access_token)
      resp_body = Utils.handle_response(resp)

      resp_body.map do |banking|
        BankingItem.new(
          @member_account,
          {
            id: banking[:id],
            type: Utils.parse_enum(banking[:type]),
            status: Utils.parse_enum(banking[:status]),
            created_at: Utils.parse_epoch(banking[:created])
          }
        )
      end
    end
  end
end
