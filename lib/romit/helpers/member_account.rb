require 'romit/errors/configuration_error'

module Romit
  class MemberAccount
    REQUIRED_METHODS = %i(
      romit_access_token romit_refresh_token romit_access_token_expires
      romit_refresh_token_expires set_access_token set_refresh_token
    )

    attr_reader :member

    def initialize(member)
      @member = member
      if !(REQUIRED_METHODS - member.methods).empty?
        raise ConfigurationError
      end
    end

    def access_token
      if Time.now.getgm > @member.romit_access_token_expires.getgm
        self.refresh
      end
      @member.romit_access_token
    end

    def refresh_token
      @member.romit_refresh_token
    end

    def refresh
      tokens = OAuth.refresh_authorization(refresh_token)
      @member.set_access_token(tokens[:access_token])
      @member.set_refresh_token(tokens[:refresh_token])
      @member.romit_access_token
    end
  end
end
