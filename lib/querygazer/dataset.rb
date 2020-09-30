module Querygazer
  class Dataset
    def initialize(ds_name)
      @name = ds_name
      @cli = Querygazer.client.dataset(ds_name)
    end
    attr_reader :name, :cli

    def to_s
      "Dataset #{self.name.inspect}"
    end
  end
end
