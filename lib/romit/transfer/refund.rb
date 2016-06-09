require 'romit/base'
require 'romit/transfer/amount'

module Romit
  class Refund < Base
    attr_reader :values

    def initialize(opts)
      if opts.nil? || opts.empty?
        @values = {}
      else
        @values = {
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

    def refund_amount
      @values[:refund_amount]
    end

    def reimburse_amount
      @values[:reimburse_amount]
    end
  end
end
