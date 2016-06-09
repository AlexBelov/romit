require 'romit/base'

module Romit
  class Token < Base
    TYPES = %i(client_token access_token refresh_token)

    def initialize(values = {})
      @values = values
    end
  end
end
