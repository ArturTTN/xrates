module Xrates
  class Driver

    def initialize()
      @adapters = []
    end

    def <<(adapter)
      @adapters << adapter
    end

    def import()
      @adapters.map{|a| Thread.new{a.fetch}.join }
    end
  end
end
