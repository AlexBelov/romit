require 'romit/helpers/member_account'

class ExampleToken
  attr_reader :romit_access_token, :romit_refresh_token
  attr_accessor :romit_access_token_expires, :romit_refresh_token_expires

  def initialize
    @romit_access_token = '702ce369-9d63-43f4-b97e-ca7f662d16be'
    @romit_refresh_token = 'd776a374-aefc-459b-bfc8-b933a75c62bf'
    @romit_access_token_expires = Time.now + 3600
    @romit_refresh_token_expires = Time.now + 3600
  end

  def save_access_token(token)
    @romit_access_token = token[:token]
  end

  def save_refresh_token(token)
    @romit_refresh_token = token[:token]
  end
end

EXAMPLE_TOKEN = ExampleToken.new
MEMBER_ACCOUNT = Romit::MemberAccount.new(EXAMPLE_TOKEN)
