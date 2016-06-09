require 'romit/helpers/member_account'

class ExampleToken
  attr_reader :romit_access_token, :romit_refresh_token
  attr_accessor :romit_access_token_expires, :romit_refresh_token_expires

  def initialize
    @romit_access_token = "7eabf1fb-6cb1-405b-a756-89ede6107f6e"
    @romit_refresh_token = "9e1fd7e5-c7b5-40bb-8663-f762359fd985"
    @romit_access_token_expires = Time.now + 3600
    @romit_refresh_token_expires = Time.now + 3600
  end

  def set_access_token(token)
    @romit_access_token = token[:token]
  end

  def set_refresh_token(token)
    @romit_refresh_token = token[:token]
  end
end

token = ExampleToken.new
MEMBER_ACCOUNT = Romit::MemberAccount.new(token)
