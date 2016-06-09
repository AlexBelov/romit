require 'spec_helper'
require 'romit'
# require "romit/transfer/refund"
# require "romit/transfer/amount"

describe Romit::Refund do
  subject { Romit::Refund }

  context 'initialize' do
    it 'initialize values with empty hash if nil is given' do
      assert_equal subject.new(nil).values, {}
    end

    it 'initialize values with amounts from API response' do
      refund_hash = {
        refundAmount: {
          currency: 'USD',
          value: '66.00'
        },
        reimburseAmount: {
          currency: 'USD',
          value: '1.39'
        }
      }

      refund = subject.new(refund_hash)
      assert_equal refund.refund_amount.class, Romit::Amount
      assert_equal refund.reimburse_amount.class, Romit::Amount
    end
  end
end
