require 'spec_helper'
require 'romit/transfer/transfer'

describe Romit::Transfer do
  subject { Romit::Transfer.new(MEMBER_ACCOUNT) }

  context 'list' do
    it 'returns list of transfers' do
      VCR.use_cassette('transfer') do
        assert_equal subject.list.first.class, Romit::TransferItem
      end
    end
  end

  context 'get' do
    it 'returns specific transfer' do
      transfer_id = '8d623beb-1640-4dce-b52d-807dbd02929a'
      VCR.use_cassette('transfer_get') do
        assert_equal subject.get(transfer_id)[:id], transfer_id
      end
    end
  end

  context 'create' do
    it 'creates transfer' do
      banking_id = VCR.use_cassette('banking') do
        Romit::Banking.new(MEMBER_ACCOUNT).list.first[:id]
      end

      opts = {
        amount: {
          currency: 'USD',
          value: '5.99'
        },
        bankingId: banking_id,
        memo: SecureRandom.hex(6),
        mode: 'AUTH_AND_CAPTURE'
      }

      VCR.use_cassette('transfer_create') do
        assert_equal subject.create(opts).class, Romit::TransferItem
      end
    end
  end

  context 'make_refund' do
    it 'refunds transfer' do
      transfer_id = VCR.use_cassette('transfer') do
        subject.list.first[:id]
      end

      VCR.use_cassette('transfer_refund') do
        assert_equal subject.make_refund(transfer_id), true
      end
    end
  end
end
