require 'romit/base'

module Romit
  class UserItem < Base
    TYPES = %i(individual business).freeze
    STATUSES = %i(not_submitted submitted approved denied).freeze

    def initialize(values = {})
      @values = values
    end
  end
end
