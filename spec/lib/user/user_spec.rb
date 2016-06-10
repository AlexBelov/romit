require 'spec_helper'
require 'romit/user/user'

describe Romit::User do
  subject { Romit::User.new(MEMBER_ACCOUNT) }

  context 'retrieve' do
    it 'returns UserItem' do
      VCR.use_cassette('user') do
        assert_equal subject.retrieve.class, Romit::UserItem
      end
    end
  end
end
