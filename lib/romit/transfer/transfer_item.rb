require 'romit/base'

module Romit
  class TransferItem < Base
    def make_refund
      resp = Client.request(:delete, "/transfer/refund/#{@values[:id]}", {}, @member_account.access_token)
      Utils.handle_response(resp)
      true
    end
  end
end
