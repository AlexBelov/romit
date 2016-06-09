require "spec_helper"
require "romit/errors/configuration_error"

describe Romit::ConfigurationError do
  subject { Romit::ConfigurationError.new }
  it "exception raisable" do
    assert_respond_to subject, :exception
  end

  context "#message" do
    it "uses passed message" do
      subject = Romit::ConfigurationError.new("custom_message")
      assert_equal subject.message, "custom_message"
    end

    it "uses default message if not passed" do
      assert_equal subject.message, Romit::ConfigurationError::MESSAGE
    end
  end
end
