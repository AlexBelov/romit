module Romit
  class IdentityDocument < Base
    def self.get(id)
      resp = Client.request(
        :get, "/identity/document/#{id}", {}, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      handle_identity_item(resp_body)
    end

    def self.create(opts = {})
      resp = Client.request(
        :post, '/identity/document', opts, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      resp_body[:id]
    end

    def self.handle_identity_item(resp_body)
      new(
        id: resp_body[:id],
        url: {
          value: resp_body[:url][:value],
          expires: Utils.parse_epoch(resp_body[:url][:expires])
        },
        type: Utils.parse_enum(resp_body[:type]),
        created_at: Utils.parse_epoch(resp_body[:created])
      )
    end
  end
end
