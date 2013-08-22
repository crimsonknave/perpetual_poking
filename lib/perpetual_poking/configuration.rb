module PerpetualPoking
  class Configuration
    attr_reader :client
    attr_accessor :api_key, :auth_token, :base_url, :log

    def set_client
      @client = Client.new({
        base_url: base_url,
        auth_token: auth_token,
        api_key: api_key,
        log: log
      })
    end

  end
end
