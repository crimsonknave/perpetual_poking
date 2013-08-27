# Shameless adapted from
# http://jeffkreeftmeijer.com/2011/method-chaining-and-lazy-evaluation-in-ruby/
module PerpetualPoking
  class Collection
    include Enumerable
    attr_accessor :meta
    def initialize(klass)
      @klass = klass
      @members = []
      @executed = false
    end

    def collection_type
      @klass
    end

    def params
      @params ||= { }
    end

    def limit(num)
      params[:limit] = num
      self
    end

    def where(args)
      params.merge!(args)
      self
    end

    def each(&block)
      unless @executed
        run
      end
      @members.each(&block)
    end

    private

    def run
      body = @klass.search(params)
      self.meta = body[:meta] if body[:meta]
      body[:results].each do |result|
        @members << @klass.new(result)
      end
      @executed = true
    end
  end
end
