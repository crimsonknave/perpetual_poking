require 'net/http'
require 'net/https'
module PerpetualPoking
  class Client
    attr_accessor :api_key, :auth_token, :base_url
    def initialize(config)
      self.api_key = config[:api_key]
      self.auth_token = config[:auth_token]
      self.base_url = config[:base_url]
      raise PerpetualPoking::ConfigurationError.new 'base_url, api_key and auth_token must be set before setting the client' if base_url.nil? or auth_token.nil? or api_key.nil?

    end

    def get(path, data = {})
      full_url = base_url + path
      uri = URI.parse(full_url)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme = 'https'
        http.use_ssl = true
      end
      request = Net::HTTP::Get.new(uri.request_uri + "?api_key=#{api_key}", {'Authorization' => "Bearer #{auth_token}"})
      PerpetualPoking::Response.new(http.request(request))
    end
    def put(path, data = {})
      puts 'unimplemented'
    end
    def post(path, data = {})
      puts 'unimplemented'
    end
    def delete(path, data = {})
      puts 'unimplemented'
    end
  end
end
