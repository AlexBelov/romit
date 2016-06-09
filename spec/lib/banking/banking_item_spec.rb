require "spec_helper"
require "romit/banking/banking_item"

describe Romit::BankingItem do
  subject { Romit::BankingItem }

  it "retrieves banking card" do
    banking_item = subject.new(
      MEMBER_ACCOUNT,
      {
        id: "2c10eeb3-4f7e-4922-8cb6-14b5786905db",
        type: :card,
        status: :unverified,
        created_at: Time.now - 3600
      }
    )
    VCR.use_cassette("banking_card_get") do
      assert_equal banking_item.retrieve.class, Romit::BankingCard
    end
  end

  it "handles unimplemented types" do
    banking_item = subject.new(
      MEMBER_ACCOUNT,
      {
        id: "2c10eeb3-4f7e-4922-8cb6-14b5786905db",
        type: :unknown,
        status: :unverified,
        created_at: Time.now - 3600
      }
    )
    assert_equal banking_item.retrieve, Romit::BankingItem::UNIMPLEMENTED_TYPE_MESSAGE
  end
end
