require 'spec_helper'
require 'romit/client'

describe Romit::Client do
  subject { Romit::Client }

  token = ExampleToken.new

  context 'request' do
    it 'raise exception if token is incorrect' do
      assert_raises Romit::APIError do
        VCR.use_cassette('wrong_token') do
          subject.request(:get, '/banking', {}, token.romit_access_token)
        end
      end
    end

    it 'raise exception if api endpoint is incorrect' do
      VCR.use_cassette('incorrect_api_endpoint') do
        assert_raises Romit::APIError do
          subject.execute_request(:get, '/incorrect_path', {}, token.romit_access_token)
        end
      end
    end
  end

  context 'request_headers' do
    it 'include access_token if necessary' do
      headers = subject.request_headers(token.romit_access_token)
      assert_includes headers[:authorization], token.romit_access_token
    end
  end

  context 'parse' do
    it 'raise exception if response is empty' do
      assert_raises Romit::APIError do
        subject.parse(nil)
      end
    end

    it 'raise exception if response is incorrect' do
      assert_raises Romit::APIError do
        subject.parse(RestClient::Response.create(';:', :test, :test, :test))
      end
    end
  end
end
