require 'rest-client'
require 'json'
require 'romit/errors/api_error'
require 'benchmark'

module Romit
  module Client
    def self.request_headers(access_token = nil)
      headers = {
        content_type: 'application/json'
      }
      if access_token
        headers.merge(authorization: "Bearer #{access_token}")
      else
        headers
      end
    end

    def self.request(method, url, params = {}, access_token = nil)
      response = execute_request(method, url, params, access_token)
      parse(response)
    end

    # rubocop:disable MethodLength
    def self.execute_request(method, url, params = {}, access_token = nil)
      api_base_url = Romit.api_base
      absolute_url = api_url(url, api_base_url)
      begin
        execute_rest_client_request(
          access_token, method, absolute_url, params
        )
      rescue RestClient::ResourceNotFound
        raise APIError, 'API endpoint is incorrect'
      rescue => e
        message = error_message(e)
        default_message = 'Seems like your token is expired or incorrect'
        raise APIError, message.empty? ? default_message : message
      end
    end

    def self.api_url(url = '', api_base_url = nil)
      (api_base_url || Romit.api_base) + url
    end

    def self.parse(response)
      JSON.parse(response.body, symbolize_names: true)
    rescue NoMethodError
      raise APIError, 'Romit response is empty'
    rescue JSON::ParserError
      raise APIError, 'Romit returned incorrect JSON'
    end

    def self.execute_rest_client_request(access_token, method, url, params)
      response = nil
      time = Benchmark.realtime do
        response = RestClient::Request.execute(
          headers: request_headers(access_token),
          method: method,
          url: url,
          payload: params.to_json,
          open_timeout: Romit.open_timeout,
          timeout: Romit.read_timeout
        )
      end
      puts "Romit API: #{format('%.2f', time)}s" if Romit.show_time
      response
    end

    def self.error_message(e)
      parse(e.response)[:error][:message]
    rescue
      ''
    end
  end
end
