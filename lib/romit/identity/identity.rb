require 'romit/helpers/utils'
require 'romit/identity/identity_item'

module Romit
  class Identity
    def initialize(member_account)
      @member_account = member_account
    end

    def list
      resp = Client.request(:get, '/identity', {}, @member_account.access_token)
      resp_body = Utils.handle_response(resp)
      resp_body.map do |identity|
        params = {
          id: identity[:id],
          type: Utils.parse_enum(identity[:type]),
          created_at: Utils.parse_epoch(identity[:created])
        }
        IdentityItem.new(@member_account, params)
      end
    end

    def create_document(opts = {})
      resp = Client.request(
        :post, '/identity/document', opts, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)

      params = {
        id: resp_body[:id],
        type: :document,
        created_at: Time.now
      }
      IdentityItem.new(@member_account, params)
    end
  end
end
