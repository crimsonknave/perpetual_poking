module PerpetualPoking
  class ConfigurationError < StandardError;end
  class AuthenticationError < StandardError;end
  class NotFoundError < StandardError;end
  class InvalidHeadersError < StandardError;end
  class ServerError < StandardError;end
end
