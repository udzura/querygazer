require 'forwardable'

module Querygazer
  class Result
    extend Forwardable

    def initialize(raw_result)
      @raw_result = raw_result
      @empty_result = false
      @single_record = false
    end
    attr_reader :raw_result

    def record
      @record ||= extract_result
    end

    def extract_result
      case raw_result.size
      when 0
        @empty_result = true
        raw_result
      when 1
        @single_record = true
        raw_result[0]
      else
        raw_result
      end
    end

    def [](key)
      case key
      when Numeric
        raw_result[key]
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

    def_delegators :record, :<, :<=, :>, :>=, :eq, :==
    def_delegators :to_a ,:first, :last, :size
  end
end
