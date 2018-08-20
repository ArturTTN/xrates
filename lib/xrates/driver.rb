module Xrates
  #
  # Driver for importing different
  # currency adapters to storage (file either redis, etc.)
  # May be set as cron job once per day
  #
  class Driver

    def initialize()
      @adapters = []
    end

    #
    # Collect adapters to run import
    # @param [Object] adapter. The object of Xrate::Adapter
    #
    # @return [Array]
    #
    # @example
    #  driver = Xrates::Driver.new
    #  driver << Xrates::Adapter::Cbr.new
    #  driver << Xrates::Adapter::Fixer.new
    #
    def <<(adapter)
      @adapters << adapter
    end

    def import()
      @adapters.map{|a| Thread.new{a.fetch}.join }
    end
  end
end
