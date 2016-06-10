module Romit
  class ConfigurationError < StandardError
    MESSAGE = 'Check implementation of your tokens storage object'.freeze

    def initialize(msg = MESSAGE)
      super
    end
  end
end
