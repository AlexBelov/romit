require 'spec_helper'
require 'romit/user/public_user'

describe Romit::PublicUser do
  subject { Romit::PublicUser }

  context 'get' do
    it 'returns UserItem' do
      client_token = VCR.use_cassette('client_token') do
        Romit::OAuth.client_access_token[:token]
      end

      VCR.use_cassette('get_public_user') do
        phone_e164 = '+11122334455'
        assert_equal(
          subject.get(client_token, phone_e164).class,
          Romit::UserItem
        )
      end
    end
  end

  context 'create' do
    it 'returns Tokens' do
      client_token = VCR.use_cassette('client_token') do
        Romit::OAuth.client_access_token[:token]
      end

      opts = {
        phone: '+11122334455',
        email: "#{SecureRandom.hex(3)}@example.com",
        first: 'FirstName',
        last: 'LastName'
      }

      tokens = VCR.use_cassette('create_public_user') do
        subject.create(client_token, opts)
      end

      assert_equal tokens[:access_token].class, Romit::Token
      assert_equal tokens[:refresh_token].class, Romit::Token
    end
  end
end
