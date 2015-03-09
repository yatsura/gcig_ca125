module GcigCa125
  class Result
    def initialize(calculator)
      @calculator = calculator
    end

    def to_s
      result_string = if @calculator.is_evaluable?
        if @calculator.is_normalised?
          if @calculator.is_response?
            "Confirmed response"
          else
            "Not confirmed"
          end
        else
          if @calculator.is_response?
            "Confirmed response"
          else
            "No response"
          end
        end
      else
        "Not evaluable"
      end
      if !@calculator.samples_28days_after_fall?
        result_string = "Not confirmed: no sample > 28 days after fall"
      end
      if !@calculator.reduced_by_half?
        result_string = "No response: no 50% reduction"
      end
      if !@calculator.first_twice_uln?
        result_string = "Not evaluable: 1st sample < 2.ULN"
      end
      if !@calculator.reduction_maintained?
        result_string = "Not confirmed: reduction not maintained"
      end
      if !@calculator.test_pre_rx?
        result_string = "Not evaluable: no sample pre-Rx"
      end
      if !@calculator.sample_within_a_week_of_rx?
        result_string = "Not evaluable: no sample within 1 week of Rx"
        if !@calculator.first_twice_uln?
          result_string = "Not evaluable: 1st sample < 2.ULN"
        end

      end
      result_string
    end

    def message
      self.to_s
    end

    def evaluable?
      @calculator.is_evaluable?
    end

    def response?
      @calculator.is_response?
    end

    def normalised?
      @calculator.is_normalised?
    end
  end
end
