module Xrates
  module Adapter
    class Fixer < Abstract
      attr_accessor :config

      def initialize(date = Time.now, config = Xrates::Config::Fixer.configuration)
        @base_currency      = "EUR"
        @config             = config
        @date               = date.strftime("%Y-%m-%d")
        @client             = Xrates::Api::Client.new("#{@config.endpoint}/#{@date}")
        super()
      end

      def fetch

        set_rates(
          @client.request(
            :get, {:access_key => @config.access_key}
          )
        )
      end

      def calculate(from_rate, to_rate)
        (BigDecimal(to_rate["value"].to_s) / BigDecimal(to_rate["nominal"])) /
         (BigDecimal(from_rate["value"].to_s) / BigDecimal(from_rate["nominal"]))
      end

      def key
        "fixer_#{@date}"
      end

      def name
        self.class.name
      end
    end
  end
end