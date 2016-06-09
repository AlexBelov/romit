require "spec_helper"
require "romit/transfer/refund"

describe Romit::Refund do
  subject { Romit::Refund }

  context "initialize" do
    it "initialize values with empty hash if nil is given" do
      assert_equal subject.new(nil).values, {}
    end

    it "initialize values with amounts from API response" do
      #token = ExampleToken.new
      #b.select{|transfer| !transfer[:refund].empty? }.first[:refund]
    end
  end
end
