require 'rest-client'
require 'json'
require 'romit/errors/api_error'

module Romit
  module Client
    def self.request_headers(access_token=nil)
      headers = {
        content_type: 'application/json'
      }
      access_token ? headers.merge(authorization: "Bearer #{access_token}") : headers
    end

    def self.request(method, url, params={}, access_token=nil)
      response = self.execute_request(method, url, params, access_token)
      self.parse(response)
    end

    def self.execute_request(method, url, params={}, access_token=nil)
      api_base_url = Romit.api_base
      absolute_url = api_url(url, api_base_url)

      begin
        RestClient::Request.execute(
          headers: request_headers(access_token), method: method, url: absolute_url,
          payload: params.to_json, open_timeout: Romit.open_timeout, timeout: Romit.read_timeout
        )
      rescue RestClient::ResourceNotFound
        raise APIError.new('API endpoint is incorrect')
      rescue
        raise APIError.new('Seems like your token is expired or incorrect')
      end
    end

    def self.api_url(url='', api_base_url=nil)
      (api_base_url || Romit.api_base) + url
    end

    def self.parse(response)
      begin
        JSON.parse(response.body, symbolize_names: true)
      rescue NoMethodError
        raise APIError.new('Romit response is empty')
      rescue JSON::ParserError
        raise APIError.new('Romit returned incorrect JSON')
      end
    end
  end
end
