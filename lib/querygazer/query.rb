require 'forwardable'

module Querygazer
  class Query
    extend Forwardable

    def initialize(sql:, cli:)
      @sql = sql
      @dataset_cli = cli
    end
    attr_reader :sql

    def to_s
      "Query #{@sql.inspect}"
    end

    def successful?
      called? || lazy_call
      @successful
    end

    def result
      called? || lazy_call
      @result
    end

    def_delegators :result, :[],
                   :first, :last,
                   :size, :length, :count

    private
    def lazy_call
      @result = Result.new(@dataset_cli.query(@sql, cache: false))
      @successful = true
    rescue => e
      @query_error = e
      @successful = false
    ensure
      @__called__ = true
    end

    def called?
      !! @__called__
    end

    def method_missing(name, *a, **b)
      if name =~ /^(?:\w|_)+\[((?:\w|_)+)\]$/
        key = $1
        key = key.to_i if key =~ /^\d+$/
        self.result[key]
      else
        super
      end
    end
  end
end
