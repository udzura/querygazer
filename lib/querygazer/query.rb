module Querygazer
  class Query
    def initialize(sql:, dataset:)
      @sql = sql
      @dataset_cli = Querygazer.client.dataset(dataset)
    end

    def to_s
      "Query #{@sql.inspect}"
    end

    def successful?
      begin
        @dataset_cli.query(@sql)
        true
      rescue => e
        false
      end
    end
  end
end
