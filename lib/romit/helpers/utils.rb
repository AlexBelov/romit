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
      if resp && !resp[:success]
        raise APIError.new(resp[:error])
      end
      begin
        resp[:response]
      rescue
        raise APIError.new("Romit response is empty")
      end
    end
  end
end
