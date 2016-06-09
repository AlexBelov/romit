require "spec_helper"
require "romit/member"

describe Romit::Member do
  subject { Romit::Member.new(ExampleToken.new) }

  it "returns passed member" do
    assert_equal subject.member_account.member.class, ExampleToken
  end

  it "refreshes member authorization" do
    previous_token = subject.member_account.access_token.clone
    VCR.use_cassette("refresh_token_1") do
      subject.refresh_authorization
    end
    refute_equal(subject.member_account.access_token, previous_token)
  end

  it "returns Banking" do
    assert_equal subject.banking.class, Romit::Banking
  end

  it "returns Transfer" do
    assert_equal subject.transfer.class, Romit::Transfer
  end

  it "returns Identity" do
    assert_equal subject.identity, Romit::Identity
  end

  it "returns User" do
    assert_equal subject.user, Romit::User
  end
end
