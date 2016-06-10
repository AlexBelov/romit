require 'spec_helper'
require 'romit/helpers/utils'

describe Romit::Utils do
  subject { Romit::Utils }

  it 'parses romit-specific unix timestamp' do
    timestamp = Time.now.to_i
    time = Time.at(timestamp)
    romit_specific_timestamp = timestamp * 1000
    assert_equal subject.parse_epoch(romit_specific_timestamp), time
  end

  it 'parses enum' do
    assert_equal subject.parse_enum('CARD'), :card
  end

  context 'handle_response' do
    it 'raises exception if romit returned error' do
      error = 'Error!'
      err = assert_raises Romit::APIError do
        subject.handle_response(success: false, error: error)
      end
      assert_equal err.message, error
    end

    it 'raises exception if romit response is nil' do
      assert_raises Romit::APIError do
        subject.handle_response(nil)
      end
    end
  end
end
