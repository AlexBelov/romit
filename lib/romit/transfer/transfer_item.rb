require 'romit/base'

module Romit
  class TransferItem < Base
    def make_refund(opts = {})
      params = { id: @values[:id] }.merge(opts)
      resp = Client.request(
        :post, '/transfer/refund', params, @member_account.access_token
      )
      Utils.handle_response(resp)
      true
    end
  end
end
