require 'romit/base'
require 'romit/banking/banking_card'

module Romit
  class BankingItem < Base
    UNIMPLEMENTED_TYPE_MESSAGE =
      'Sorry, this type is not implemented yet'.freeze

    def retrieve
      case @values[:type]
      when :card
        BankingCard.new(@member_account).get(@values[:id])
      else
        UNIMPLEMENTED_TYPE_MESSAGE
      end
    end
  end
end
