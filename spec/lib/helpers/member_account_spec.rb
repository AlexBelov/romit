require 'spec_helper'
require 'romit/helpers/member_account'

describe Romit::MemberAccount do
  subject { Romit::MemberAccount }

  context 'initialize' do
    it "raise exception if given member doesn't respond to all necessary methods" do
      assert_raises Romit::ConfigurationError do
        subject.new({})
      end
    end
  end

  context 'access_token' do
    it 'refreshes token if expired' do
      expired_token = ExampleToken.new
      expired_token.romit_access_token_expires = Time.now - 3600
      member_account_with_expired_token = subject.new(expired_token.clone)
      VCR.use_cassette('refresh_token_2') do
        refute_equal member_account_with_expired_token.access_token, expired_token.romit_access_token
      end
    end
  end
end
