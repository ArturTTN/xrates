module Xrates
  class Currency
    module Arithmetic

      def -(curr); calculate('-', curr) end

      def +(curr); calculate('+', curr) end

      def /(curr); calculate('/', curr) end

      def *(curr); calculate('*', curr) end


      def calculate(math_method, currency)
        raise TypeError, "Should be Xrates::Currency" unless currency.is_a?(Xrates::Currency)

        if self.code != currency.code
          currency = currency.convert_to(@code)
        end

        self.class.new(
          (BigDecimal(@amount.to_s).send( math_method, BigDecimal(currency.amount.to_s))).to_f.round(@round),
          @code,
          @driver)
      end
    end
  end
end