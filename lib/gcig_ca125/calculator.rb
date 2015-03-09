require 'date'

module GcigCa125
  class Calculator
    def initialize(rx_date, normal_range=(0..30))
      @normal_range = normal_range
      @rx_date = rx_date
      @tests = []
    end

    def result
      Result.new self
    end

    def add_ca125_test(date, value)
      @tests << [date, value]
      sort_tests
    end

    def is_evaluable?
      sample_before_rx? && sample_within_a_week_of_rx? && first_twice_uln?
    end

    def is_response?
      if is_evaluable?
        @tests.select { |test| (test[0] > day_28_after_fall ) && test[1] < half_of_first }.any?
      else
        false
      end
    end

    def is_normalised?
      find_normalised().any?
    end

    def samples_28days_after_fall?
      test = Proc.new do |item|
        item[0] > day_28_after_fall
      end
      @tests.select(&test).any?
    end

    def reduced_by_half?
      (@tests.last[1].to_f / @tests.first[1].to_f ) <= 0.5
    end

    def first_twice_uln?
      @tests.first[1] > @normal_range.max * 2
    end

    def test_pre_rx?
      sample_before_rx? && sample_within_a_week_of_rx?
    end

    def sample_before_rx?
      @tests.first[0] <= @rx_date
    end

    def sample_within_a_week_of_rx?
      @tests.first[0] >= (@rx_date - 9)
    end

    def reduction_maintained?
      test =  Proc.new do |item|
        item[0] > day_28_after_fall && item[1] > (value_at_fall+15)
      end
      @tests.select(&test).empty?
    end

    def sort_tests
      @tests = @tests.sort { |a,b| a[0] <=> b[0] }
    end

    private
    def day_28_after_fall
      date_of_fall + 28
    end

    def date_of_fall
      if tests_after_fall.any?
        tests_after_fall.first[0]
      else
        Date.parse('2999-01-01')
      end
    end

    def value_at_fall
      tests_after_fall.first[1] if tests_after_fall.any?
    end

    def tests_after_fall
      valid_response = Proc.new do |test|
        (test[1] < half_of_first) && (test[0] > (@tests.first[0]))
      end
      @tests.select(&valid_response)
    end

    def half_of_first
      @tests.first[1] / 2.0
    end

    def find_normalised
      @tests.select { |test| @normal_range.include? test[1] }
    end
  end
end
