require "spec_helper"
require "romit/banking/banking"

describe Romit::Banking do
  subject { Romit::Banking.new(MEMBER_ACCOUNT) }

  it "returns banking items list" do
    VCR.use_cassette("banking") do
      assert_equal subject.list.first.class, Romit::BankingItem
    end
  end
end
