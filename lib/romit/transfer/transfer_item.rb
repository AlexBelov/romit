require 'romit/base'

module Romit
  class TransferItem < Base
    def make_refund
      endpoint = "/transfer/refund/#{@values[:id]}"
      resp = Client.request(
        :delete, endpoint, {}, @member_account.access_token
      )
      Utils.handle_response(resp)
      true
    end
  end
end
