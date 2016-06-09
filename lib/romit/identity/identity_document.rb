module Romit
  class IdentityDocument < Base
    def self.get(id)
      resp = Client.request(:get, "/identity/document/#{id}", {}, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      self.new(
        id: resp_body[:id],
        url: {
          value: resp_body[:url][:value],
          expires: Utils.parse_epoch(resp_body[:url][:expires])
        },
        type: Utils.parse_enum(resp_body[:type]),
        created_at: Utils.parse_epoch(resp_body[:created])
      )
    end

    def self.create(romit_model, opts = {})
      resp = Client.request(:post, '/identity/document', opts, MemberAccount.access_token)
      resp_body = Utils.handle_response(resp)
      resp_body[:id]
    end
  end
end
