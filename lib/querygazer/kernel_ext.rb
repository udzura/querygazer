module Querygazer
  module KernelExt
    def dataset(name)
      Dataset.new(name)
    end

    def query(sql)
      Query.new(sql: sql, dataset: Querygazer.dataset)
    end
  end
end

self.extend Querygazer::KernelExt
