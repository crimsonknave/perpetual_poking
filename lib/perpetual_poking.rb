require 'cot'

require 'perpetual_poking/version'
require 'perpetual_poking/client'
require 'perpetual_poking/configuration'
require 'perpetual_poking/exceptions'
require 'perpetual_poking/response'

require 'perpetual_poking/contact'

module PerpetualPoking
  class << self

    def configure(&block)
      yield(conf)
      conf.set_client
      conf
    end

    def conf
      @_configuration ||= Configuration.new
    end

    def client
      conf.client
    end

    def version_string
      "Perpetual Poking version #{PerpetualPoking::VERSION}"
    end
  end
end
