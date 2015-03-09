module GcigCa125
  class Result
    def initialize(eva, res, norm)
      @evaluable = eva
      @response  = res
      @normalised = norm
    end
    def to_s
      if evaluable? && !response? && !normalised?
        "No response"
      elsif evaluable? && normalised? && !response?
        "Not confirmed"
      elsif evaluable? && normalised? && response?
        "Confirmed response"
      else
        "Not evaluable"
      end

    end

    def message
      self.to_s
    end

    def evaluable?
      @evaluable
    end

    def response?
      @response
    end

    def normalised?
      @normalised
    end

  end
end
