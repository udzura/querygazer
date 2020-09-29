require "rspec"
require "rspec/its"
require "google/cloud/bigquery"
require "querygazer/version"
require "querygazer/dataset"
require "querygazer/query"
require "querygazer/kernel_ext"
require "querygazer/example_group_ext"

module Querygazer
  class << self
    def setup!(credentials: nil, &blk)
      if blk
        Google::Cloud::Bigquery.configure(&blk)
        @client ||= Google::Cloud::Bigquery.new
      else
        @client ||= Google::Cloud::Bigquery.new(credentials: credentials)
      end
    end

    def client
      @client
    end
  end
end
