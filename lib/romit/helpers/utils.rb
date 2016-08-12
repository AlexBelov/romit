module Romit
  module Utils
    def self.parse_timestamp(created)
      Time.parse(created)
    end

    def self.parse_epoch(epoch)
      Time.at(epoch.to_s[0..-4].to_i)
    end

    def self.parse_enum(type)
      type.downcase.to_sym
    end

    def self.handle_response(resp)
      raise(APIError, resp[:error]) if resp && !resp[:success]
      begin
        resp[:response]
      rescue
        raise APIError, 'Romit response is empty'
      end
    end

    def self.handle_auth_response(resp)
      raise(APIError, resp[:error]) if resp && !resp[:success]
      begin
        resp[:success]
      rescue
        raise APIError, 'Romit response is empty'
      end
    end

    def self.handle_token(name, resp_body, client = false)
      Token.new(
        type: client ? :client_token : name.to_sym,
        token: resp_body[name.to_sym],
        expires: parse_timestamp(
          resp_body["#{name}_expires".to_sym]
        )
      )
    end
  end
end
