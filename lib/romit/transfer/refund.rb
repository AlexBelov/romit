require 'romit/base'
require 'romit/transfer/amount'

module Romit
  class Refund < Base
    attr_reader :values

    def initialize(opts)
      @values = opts.nil? || opts.empty? ? {} : refund_params(opts)
    end

    def refund_amount
      @values[:refund_amount]
    end

    def reimburse_amount
      @values[:reimburse_amount]
    end

    private

    def refund_params(opts)
      {
        refund_amount: Amount.new(
          currency: opts[:refundAmount][:currency],
          value: opts[:refundAmount][:value]
        ),
        reimburse_amount: Amount.new(
          currency: opts[:reimburseAmount][:currency],
          value: opts[:reimburseAmount][:value]
        )
      }
    end
  end
end
