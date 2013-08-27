require 'net/http'
require 'net/https'
require 'cgi'
module PerpetualPoking
  class Client
    attr_accessor :api_key, :auth_token, :base_url
    def initialize(config)
      self.api_key = config[:api_key]
      self.auth_token = config[:auth_token]
      self.base_url = config[:base_url]
      raise PerpetualPoking::ConfigurationError.new 'base_url, api_key and auth_token must be set before setting the client' if base_url.nil? or auth_token.nil? or api_key.nil?

    end

    def rest_setup(path)
      full_url = base_url + path
      uri = URI.parse(full_url)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme = 'https'
        http.use_ssl = true
      end
      return http, uri
    end
    def get(path, data = {})
      puts 'making a get'
      http, uri = rest_setup(path)
      params = data.merge(api_key: api_key)
      request = Net::HTTP::Get.new(uri.request_uri + parameterize(params), {'Authorization' => "Bearer #{auth_token}"})
      PerpetualPoking::Response.new(http.request(request))
    end
    def put(path, data = {})
      puts 'making a put'
      http, uri = rest_setup(path)
      request = Net::HTTP::Put.new(uri.request_uri + parameterize(api_key: api_key), {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{auth_token}"})
      request.body = data.to_json
      PerpetualPoking::Response.new(http.request(request))
    end
    def post(path, data = {})
      puts 'unimplemented'
    end
    def delete(path, data = {})
      puts 'unimplemented'
    end

    private

    def parameterize(params)
      escaped_params = {}
      params.each_pair do |k,v|
        escaped_params[CGI::escape(k.to_s)] = CGI::escape(v.to_s)
      end
      output = escaped_params.map{|k,v| "#{k}=#{v}"}.join('&')
      output.empty? ? '' : "?#{output}"
    end
  end
end
