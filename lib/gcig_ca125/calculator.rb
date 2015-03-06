require 'date'

module GcigCa125
  class Calculator
    def initialize(rx_date, normal_range=(0..30))
      @normal_range = normal_range
      @rx_date = rx_date
      @tests = []
    end

    def result
      Result.new is_evaluable?, is_response?, is_normalised?
    end

    def add_ca125_test(date, value)
      @tests << [date, value]
      sort_tests
    end

    def is_evaluable?
      @evaluable = (@tests.first[0] <= @rx_date) && (@tests.first[0] >= (@rx_date - 9))
      @evaluable = (@tests.first[1] > @normal_range.max * 2) if @evaluable
    end

    def is_response?
      if is_evaluable?
        @tests.select { |test| (test[0] > date_of_fall + 28 ) && test[1] < half_of_first }.any?
      else
        @response = false
      end
    end

    def is_normalised?
      @normalised = find_normalised
      @normalised.any?
    end

    def sort_tests
      @tests = @tests.sort { |a,b| a[0] <=> b[0] }
    end

    private
    def date_of_fall
      valid_response = Proc.new do |test|
        #(test[1] < half_of_first) && (test[0] > (@rx_date + 28))
        (test[1] < half_of_first) && (test[0] > (@tests.first[0]))
      end
      if @tests.select(&valid_response).any?
        @tests.select(&valid_response).first[0]
      else
        Date.parse('2999-01-01')
      end
    end
    def half_of_first
      @tests.first[1] / 2.0
    end

    def find_normalised
      @tests.select { |test| @normal_range.include? test[1] }
    end
  end
end
