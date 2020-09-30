module Querygazer
  class Query
    def initialize(sql:, cli:)
      @sql = sql
      @dataset_cli = cli
    end

    def to_s
      "Query #{@sql.inspect}"
    end

    def successful?
      called? || lazy_call
      @successful
    end

    def raw_result
      called? || lazy_call
      @raw_result
    end

    def result
      r = raw_result[0]
      r.size == 1 ? r.values[0] : r
    end

    private
    def lazy_call
      @raw_result = @dataset_cli.query(@sql)
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
  end
end
