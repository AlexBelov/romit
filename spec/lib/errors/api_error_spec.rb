require "spec_helper"
require "romit/errors/api_error"

describe Romit::APIError do
  subject { Romit::APIError.new }
  it "exception raisable" do
    assert_respond_to subject, :exception
  end

  context "#message" do
    it "uses passed message" do
      subject = Romit::APIError.new("custom_message")
      assert_equal subject.message, "custom_message"
    end

    it "uses default message if not passed" do
      assert_equal subject.message, Romit::APIError::MESSAGE
    end
  end

  context "#to_s" do
    it "uses passed http status" do
      status = "501"
      subject = Romit::APIError.new(nil, status)
      assert_includes subject.to_s, status
    end
  end
end
