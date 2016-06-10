require 'spec_helper'
require 'romit/oauth'

describe Romit::OAuth do
  subject { Romit::OAuth }

  context 'access_token' do
    it 'returns Token' do
      VCR.use_cassette('client_token') do
        assert_equal subject.client_access_token.class, Romit::Token
      end
    end
  end

  context 'request_user_authorization_link' do
    it 'returns auth link' do
      assert_includes subject.request_user_authorization_link(
        'redirect_uri_param',
        '',
        'state_param'
      ), 'redirect_uri_param', 'state_param'
    end
  end

  context 'finish_user_authorization' do
    it 'returns Tokens' do
      VCR.use_cassette('finish_user_authorization') do
        tokens = subject.finish_user_authorization(
          'http://d68cd05f.ngrok.io/romit/finish',
          '791e48ad-c43e-4410-883b-5c903a92d7ca'
        )
        assert_equal tokens[:access_token].class, Romit::Token
        assert_equal tokens[:refresh_token].class, Romit::Token
      end
    end
  end

  context 'auth_url' do
    it 'returns live auth_url' do
      assert_equal subject.auth_url('https://api.romit.io/v1'),
                   subject::LIVE_AUTH
    end

    it 'returns sandbox auth_url' do
      assert_equal subject.auth_url('https://api.sandbox.romit.io/v1'),
                   subject::SANDBOX_AUTH
    end
  end
end
