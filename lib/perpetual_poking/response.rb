module PerpetualPoking
  class Response
    attr_reader :code, :message, :body
    def initialize(response)
      @code = response.code.to_i
      #puts self.code
      raise PerpetualPoking::InvalidQuery.new self.body if self.code == 400
      raise PerpetualPoking::AuthenticationError.new self.body if self.code == 401
      raise PerpetualPoking::NotFoundError.new self.body if self.code == 404
      # This *should* never come up since we should be setting them correctly
      raise PerpetualPoking::InvalidHeadersError.new self.body if self.code == 406
      raise PerpetualPoking::ServerError.new self.body unless [200, 201].include? self.code
      @message = response.message
      @body = JSON.parse(response.body).with_indifferent_access
    end
  end
end
