require 'romit/client'
require 'romit/transfer/amount'
require 'romit/transfer/refund'
require 'romit/transfer/transfer_item'

module Romit
  class Transfer
    def initialize(member_account)
      @member_account = member_account
    end

    def list
      resp = Client.request(
        :get, '/transfer', {}, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      resp_body.map { |transfer| handle_transfer(transfer) }
    end

    def get(id)
      resp = Client.request(
        :get, "/transfer/#{id}", {}, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      handle_transfer(resp_body)
    end

    def make_refund(id, opts = {})
      params = { id: id }.merge(opts)
      resp = Client.request(
        :post, '/transfer/refund', params, @member_account.access_token
      )
      Utils.handle_response(resp)
      true
    end

    def create(opts = {})
      resp = Client.request(
        :post, '/transfer', opts, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      params = { id: resp_body[:id] }
      TransferItem.new(@member_account, params)
    end

    # rubocop:disable MethodLength
    # rubocop:disable Metrics/AbcSize
    def handle_transfer(resp_body)
      params = {
        id: resp_body[:id],
        from: resp_body[:from],
        to: resp_body[:to],
        by: resp_body[:by],
        from_amount: Amount.new(
          currency: resp_body[:fromAmount][:currency],
          value: resp_body[:fromAmount][:value]
        ),
        to_amount: Amount.new(
          currency: resp_body[:fromAmount][:currency],
          value: resp_body[:fromAmount][:value]
        ),
        banking_id: resp_body[:banking_id],
        memo: resp_body[:memo],
        type: Utils.parse_enum(resp_body[:type]),
        status: Utils.parse_enum(resp_body[:status]),
        refund: Refund.new(resp_body[:refund]),
        created_at: Utils.parse_epoch(resp_body[:created])
      }
      TransferItem.new(@member_account, params)
    end
  end
end
