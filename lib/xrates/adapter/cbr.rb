module Xrates
  module Adapter
    class Cbr < Abstract
      attr_accessor :config

      def initialize(date = Time.now, config = Xrates::Config::Cbr.configuration)
        @base_currency      = "RUB"
        @config             = config
        @date               = date.strftime("%d.%m.%Y")
        @client             = Xrates::Api::Client.new(@config.endpoint)
        super()
      end

      def fetch

        set_rates(
          @client.request(
            :get, {:date_req => @date}
          )
        )
      end

      def calculate(from_rate, to_rate)
        (BigDecimal(from_rate["value"].to_s) / BigDecimal(from_rate["nominal"])) /
         (BigDecimal(to_rate["value"].to_s) / BigDecimal(to_rate["nominal"]))
      end

      def key
        "cbr_#{@date}"
      end

      def name
        self.class.name
      end
    end
  end
end