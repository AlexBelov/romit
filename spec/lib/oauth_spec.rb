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

  context 'request_user_authorization' do
    it 'return correct response' do
      client_token = VCR.use_cassette('client_token') do
        Romit::OAuth.client_access_token[:token]
      end

      params = {
        redirect_uri: 'https://nugg-backend-dev.herokuapp.com/api/public/romit/auth_callback',
        state: 'some state',
        phone: '+19492572313',
        email: 'first.last@example.com',
        first: 'First',
        last: 'Last',
        call: false,
        refresh: true
      }

      VCR.use_cassette('request_user_authorization') do
        assert_equal subject.request_user_authorization(client_token, params), true
      end
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
end
