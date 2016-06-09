require 'romit/amount'
require 'romit/transfer/refund'

module Romit
  class Transfer < Base
    def self.list
      resp = Client.request(:get, "/transfer", {}, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      resp_body.map{|transfer| handle_transfer(transfer)}
    end

    def self.get(id)
      resp = Client.request(:get, "/transfer/#{id}", {}, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      handle_transfer(resp_body)
    end

    def retrieve
      resp = Client.request(:get, "/transfer/#{@@values[:id]}", {}, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      handle_transfer(resp_body)
    end

    def self.create(opts = {})
      resp = Client.request(:post, "/transfer", opts, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      self.new(
        id: resp_body[:id]
      )
    end

    def self.refund(id)
      resp = Client.request(:delete, "/transfer/refund/#{id}", {}, MemberAccount.access_token)
      Utils.handle_response(resp)
      true
    end

    def refund
      resp = Client.request(:delete, "/transfer/refund/#{@values[:id]}", {}, MemberAccount.access_token)
      Utils.handle_response(resp)
      true
    end

    def self.handle_transfer(resp_body)
      self.new(
        id: resp_body[:id],
        from: resp_body[:from],
        to: resp_body[:to],
        by: resp_body[:by],
        from_amount: Amount.new(
          currency: resp_body[:fromAmount][:currency],
          value: resp_body[:fromAmount][:value],
        ),
        to_amount: Amount.new(
          currency: resp_body[:fromAmount][:currency],
          value: resp_body[:fromAmount][:value],
        ),
        banking_id: resp_body[:banking_id],
        memo: resp_body[:memo],
        type: Utils.parse_enum(resp_body[:type]),
        status: Utils.parse_enum(resp_body[:status]),
        refund: Refund.new(resp_body[:refund]),
        created_at: Utils.parse_epoch(resp_body[:created])
      )
    end
  end
end
