require 'romit/errors/configuration_error'
require 'romit/oauth'

module Romit
  class MemberAccount
    REQUIRED_METHODS = %i(
      romit_access_token romit_refresh_token romit_access_token_expires
      romit_refresh_token_expires save_access_token save_refresh_token
    ).freeze

    attr_reader :member

    def initialize(member)
      @member = member
      raise ConfigurationError unless (REQUIRED_METHODS - member.methods).empty?
    end

    def access_token
      refresh if Time.now.getgm > @member.romit_access_token_expires.getgm
      @member.romit_access_token
    end

    def refresh_token
      @member.romit_refresh_token
    end

    def refresh
      tokens = OAuth.refresh_authorization(refresh_token)
      @member.save_access_token(tokens[:access_token])
      @member.save_refresh_token(tokens[:refresh_token])
      @member.romit_access_token
    end
  end
end
