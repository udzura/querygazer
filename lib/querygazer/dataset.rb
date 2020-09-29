module Querygazer
  class Dataset
    def initialize(ds_name)
      @name = ds_name
    end
    attr_reader :name
  end
end
