require 'forwardable'

module Querygazer
  class Result
    extend Forwardable

    def initialize(raw_result)
      @raw_result = raw_result
      @empty_result = false
      @single_record = false
      @record = extract_result
    end
    attr_reader :raw_result, :record

    def value
      record.values[0]
    end

    def extract_result
      case raw_result.size
      when 0
        @empty_result = true
        {}
      when 1
        @single_record = (raw_result[0].keys.size == 1)
        raw_result[0]
      else
        # record should be first record
        raw_result[0]
      end
    end

    def [](key)
      case key
      when Numeric
        raw_result[key].values
      when Symbol, String
        record[key.to_sym]
      else
        raise KeyError, "Maybe invalid key specified"
      end
    end

    def to_a
      record.values
    end
    alias to_record to_a

    def to_records
      raw_result
    end

    [
      :<, :<=, :>, :>=, :==, :eq, # for be <, be >=, ...
      :-, :+ # for be_within
    ].each do |op|
      define_method op do |arg0|
        if arg0.is_a?(Hash) || arg0.is_a?(Array)
          self.record.send(op, arg0)
        else
          self.value.send(op, arg0)
        end
      end
    end

    [:first, :last].each do |msg|
      define_method msg do
        self.to_records.send(msg).values
      end
    end

    def_delegators :to_records, :size, :length, :count
  end
end
