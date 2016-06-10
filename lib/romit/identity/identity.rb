module Romit
  class Identity < Base
    def self.list
      resp = Client.request(:get, '/identity', {}, @member_account.access_token)
      resp_body = Utils.handle_response(resp)
      resp_body.map do |identity|
        new(
          id: identity[:id],
          type: Utils.parse_enum(identity[:type]),
          created_at: Utils.parse_epoch(identity[:created])
        )
      end
    end

    def retrieve
      case @values[:type]
      when :document
        IdentityDocument.get(@values[:id])
      else
        'Sorry, this type is not implemented yet'
      end
    end
  end
end
