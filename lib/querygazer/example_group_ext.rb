module Querygazer
  module ExampleGroupExt
    def query(sql)
      dataset = metadata[:description].name
      Query.new(sql: sql, dataset: dataset)
    end
  end
end

class RSpec::Core::ExampleGroup
  extend Querygazer::ExampleGroupExt
  include Querygazer::ExampleGroupExt
end