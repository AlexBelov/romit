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
  define_setting :show_time, false
end
