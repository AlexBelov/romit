module Romit
  class Base
    def initialize(member_account, values = {})
      @member_account = member_account
      @values = values
    end

    def to_hash
      @values
    end

    def [](k)
      @values[k.to_sym]
    end

    def []=(k, v)
      @values[k] = v
    end

    def keys
      @values.keys
    end

    def values
      @values.values
    end
  end
end
