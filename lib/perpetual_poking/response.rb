module PerpetualPoking
  class Response
    attr_reader :code, :message, :body
    def initialize(response)
      @code = response.code.to_i
      @message = response.message
      @body = JSON.parse(response.body)
    end
  end
end
