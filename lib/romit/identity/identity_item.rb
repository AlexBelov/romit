require 'romit/base'
require 'romit/identity/identity_document'

module Romit
  class IdentityItem < Base
    UNIMPLEMENTED_TYPE = 'Sorry, this type is not implemented yet'.freeze

    def retrieve
      case @values[:type]
      when :document
        params = { id: @values[:id] }
        IdentityDocument.new(@member_account, params).retrieve
      else
        UNIMPLEMENTED_TYPE
      end
    end
  end
end
