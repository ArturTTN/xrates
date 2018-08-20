module Xrates
  module Adapter

    class UnknownRate < StandardError; end
    class NotImplementedError < StandardError; end

    class Abstract

      def initialize
        @storage  = @config.cache.new
        @parser   = @config.parser.new
        @rates    = nil
      end

      def rates
        @rates
      end

      def get_rates
        @storage.get(key)
      end

      def set_rates(response)

        return @rates if @rates = get_rates

        base_rate = {}
        base_rate[@base_currency] = {
          "nominal"  => 1,
          "value"    => 1
        }

        @rates = @parser.parse(response.body).merge(base_rate)
        @storage.set(key, @rates)
        @rates
      end

      def exchange(curr, code, round)

        rate      = fetch()
        from_rate = rate[curr.code]
        to_rate   = rate[code]

        if from_rate.nil? || to_rate.nil?
          raise UnknownRate, "No conversion rate for '#{curr.code}' -> '#{code}' for #{name}"
        end

        curr.class.new(
          (BigDecimal(curr.amount.to_s) * calculate(from_rate, to_rate)).to_f.round(round),
          code,
          self
        )
      end


      def fetch; raise NotImplementedError, "Implement this method in a child class" end
      def key; raise NotImplementedError, "Implement this method in a child class" end
    end
  end
end