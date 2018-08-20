require_relative "currency/arithmetic"

module Xrates

  # Thrown when driver did not exists
  class NoDriverSettledError < StandardError; end

  #
  # Class is used for rate conversion
  # it uses different drivers, wich are passed during initialization
  # @example
  #  adapter = Xrates::Adapter::Cbr.new
  #  Xrates::Currency.new(1000, "EUR", cbr)
  #
  class Currency

    include Xrates::Currency::Arithmetic

    attr_accessor :code, :amount, :driver

    #
    # Initializes a new Currency object.
    # @param [Float] amount The amount of currency
    # @param [String] code The char code of currency
    # @param [Xrates::Adapter::Abstract] driver The adapter to convert with
    #
    def initialize(amount, code, driver = nil)
      @amount     = amount
      @code       = code
      @driver     = driver
      @round      = 2
    end

    #
    # Convert Xrates::Currency to another Xrates::Currency object
    # @param [String] char_code The currency code to convert to
    # @param [Integer] round The value of round amount
    # @return [Xrates::Currency]
    #
    def convert_to(char_code, round = 2)
      raise NoDriverSettledError if @driver.nil?

      @round = round
      return self if self.code == char_code
      @driver.exchange(self, char_code, round)
    end

    #
    # Convert Xrates::Currency to another Xrates::Currency object
    # @param [Array] char_codes The array of currencies code to convert to
    # @param [Integer] round The value of round amount
    # @return [Array]
    #
    def convert_list(char_codes, round = 2)
      char_codes.map do |char_code|
        convert_to(char_code, round)
      end
    end
  end
end
