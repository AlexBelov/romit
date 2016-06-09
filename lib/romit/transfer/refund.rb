require 'romit/amount'

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

      def empty?
        @values.empty?
      end
    end
  end
end
