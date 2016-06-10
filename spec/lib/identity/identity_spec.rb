require 'spec_helper'
require 'base64'
require 'romit/identity/identity'

describe Romit::Identity do
  subject { Romit::Identity.new(MEMBER_ACCOUNT) }

  context 'list' do
    it 'returns list of IdentityItems' do
      VCR.use_cassette('identity') do
        assert_equal subject.list.first.class, Romit::IdentityItem
      end
    end
  end

  context 'create_document' do
    it 'returns IdentityItem' do
      image_file = File.open('spec/test_files/driver_license.jpg', 'rb').read
      base64_image = Base64.encode64(image_file)
      opts = {
        file: base64_image,
        type: 'DRIVERS_LICENSE'
      }
      VCR.use_cassette('identity_document_create') do
        assert_equal subject.create_document(opts).class, Romit::IdentityItem
      end
    end
  end
end
