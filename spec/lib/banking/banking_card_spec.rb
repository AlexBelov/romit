require "spec_helper"
require "romit/banking/banking_card"

describe Romit::BankingCard do
  subject { Romit::BankingCard.new(MEMBER_ACCOUNT) }

  it "creates banking card" do
    card_opts =  {
      name: "Chadd Sexington",
      number: "4556899287487842",
      month: 9,
      year: 2017,
      cvv: "947",
      postal: "89101"
    }
    VCR.use_cassette("banking_card_create") do
      assert_equal subject.create(card_opts).class, Romit::BankingItem
    end
  end

  it "deletes banking card" do
    VCR.use_cassette("banking_card_delete") do
      assert_equal subject.delete("aaa5f979-e932-489e-b490-2c8b7ca0b818"), true
    end
  end
end
