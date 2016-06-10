# Romit Ruby bindings
# API spec at http://docs.romit.io/

require 'romit/version'

require 'romit/helpers/configuration'
require 'romit/member'
require 'romit/oauth'

module Romit
  extend Configuration

  define_setting :api_base, 'https://api.sandbox.romit.io/v1'
  define_setting :client_id, '***REMOVED***'
  define_setting :client_secret, '***REMOVED***'
  define_setting :open_timeout, 30
  define_setting :read_timeout, 80

  class ExampleToken
    attr_reader :romit_access_token, :romit_refresh_token
    attr_accessor :romit_access_token_expires, :romit_refresh_token_expires

    def initialize
      @romit_access_token = '702ce369-9d63-43f4-b97e-ca7f662d16be'
      @romit_refresh_token = 'd776a374-aefc-459b-bfc8-b933a75c62bf'
      @romit_access_token_expires = Time.now + 3600
      @romit_refresh_token_expires = Time.now + 3600
    end

    def save_access_token(token)
      @romit_access_token = token[:token]
    end

    def save_refresh_token(token)
      @romit_refresh_token = token[:token]
    end
  end
end
