require 'romit/helpers/member_account'
require 'romit/banking/banking'
require 'romit/transfer/transfer'
require 'romit/identity/identity'
require 'romit/user/user'

module Romit
  class Member
    attr_reader :member_account

    def initialize(member)
      @member_account = MemberAccount.new(member)
    end

    def refresh_authorization
      @member_account.refresh
    end

    def banking
      Banking.new(@member_account)
    end

    def transfer
      Transfer.new(@member_account)
    end

    def identity
      Identity
    end

    def user
      User
    end
  end
end
