require 'romit/helpers/member_account'

class ExampleToken
  attr_reader :romit_access_token, :romit_refresh_token
  attr_accessor :romit_access_token_expires, :romit_refresh_token_expires

  def initialize
    @romit_access_token = 'aa6a3cad-3c98-4d06-a0e3-6a38056e8d75'
    @romit_refresh_token = 'dfccee68-7007-42bb-91b6-e6cc752d79d9'
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
