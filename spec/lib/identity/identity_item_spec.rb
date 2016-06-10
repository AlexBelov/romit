require 'spec_helper'
require 'romit/identity/identity'
require 'romit/identity/identity_item'

describe Romit::IdentityItem do
  identity = Romit::Identity.new(MEMBER_ACCOUNT)
  subject { identity.list.first }

  context 'retrieve' do
    it 'returns something with id' do
      VCR.use_cassette('identity_get') do
        assert_equal subject.retrieve[:id].empty?, false
      end
    end

    it 'prints unimplemented warning' do
      VCR.use_cassette('identity_get') do
        subject[:type] = :unknown
        assert_equal subject.retrieve, Romit::IdentityItem::UNIMPLEMENTED_TYPE
      end
    end
  end
end
