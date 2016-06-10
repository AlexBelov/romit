module Romit
  class IdentityDocument < Base
    TYPES = %w(
      DRIVERS_LICENSE GENERIC_ID PASSPORT VISA FACE_PICTURE_WITH_ID
      BUSINESS_ARTICLES BUSINESS_BANK_STATEMENT BUSINESS_LICENSE
      BUSINESS_VOIDED_CHECK BUSINESS_PROCESSING_STATEMENT
      BUSINESS_MARKETING_MATERIALS BUSINESS_W9 BUSINESS_SIGNOR_ID
    ).freeze

    def retrieve
      url = "/identity/document/#{@values[:id]}"
      resp = Client.request(
        :get, url, {}, @member_account.access_token
      )
      resp_body = Utils.handle_response(resp)
      handle_identity_document(resp_body)
      self
    end

    def handle_identity_document(resp_body)
      params = {
        id: resp_body[:id],
        url: {
          value: resp_body[:url][:value],
          expires: Utils.parse_epoch(resp_body[:url][:expires])
        },
        type: Utils.parse_enum(resp_body[:type]),
        created_at: Utils.parse_epoch(resp_body[:created])
      }
      @values = params
    end
  end
end
