# Romit Ruby bindings
# API spec at http://docs.romit.io/

# Version
require "romit/version"

require 'romit/helpers/configuration'
require 'romit/helpers/utils'
require 'romit/helpers/member_account'
require 'romit/member'

require 'romit/base'
require 'romit/client'

require 'romit/oauth'

require 'romit/user/user'
require 'romit/user/public_user'

require 'romit/banking/banking'
require 'romit/banking/banking_card'
require 'romit/transfer/transfer'

require 'romit/identity/identity'
require 'romit/identity/identity_document'

module Romit
  extend Configuration

  define_setting :api_base, "https://api.sandbox.romit.io/v1"
  define_setting :client_id, "***REMOVED***"
  define_setting :client_secret, "***REMOVED***"
  define_setting :open_timeout, 30
  define_setting :read_timeout, 80

  class ExampleToken
    attr_reader :romit_access_token, :romit_refresh_token
    attr_accessor :romit_access_token_expires, :romit_refresh_token_expires

    def initialize
      @romit_access_token = "7eabf1fb-6cb1-405b-a756-89ede6107f6e"
      @romit_refresh_token = "9e1fd7e5-c7b5-40bb-8663-f762359fd985"
      @romit_access_token_expires = Time.now + 3600
      @romit_refresh_token_expires = Time.now + 3600
    end

    def set_access_token(token)
      @romit_access_token = token[:token]
    end

    def set_refresh_token(token)
      @romit_refresh_token = token[:token]
    end
  end

end
