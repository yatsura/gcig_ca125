module GcigCa125
  class Result
    def initialize(eva, res, norm)
      @evaluable = eva
      @response  = res
      @normalised = norm
    end
    def to_s
      "Not evaluable"
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
