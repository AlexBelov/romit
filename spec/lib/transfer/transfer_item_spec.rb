require 'spec_helper'
require 'romit/transfer/transfer_item'

describe Romit::TransferItem do
  transfer_id = { id: '385e07f2-db0b-4726-9e19-07935e87bbfb' }
  subject { Romit::TransferItem.new(MEMBER_ACCOUNT, transfer_id) }

  context 'make_refund' do
    it 'refunds transfer' do
      VCR.use_cassette('transfer_item_refund') do
        assert_equal subject.make_refund, true
      end
    end
  end
end
