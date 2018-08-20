require_relative "currency/arithmetic"

module Xrates

  class NoDriverSettledError < StandardError; end

  class Currency

    include Xrates::Currency::Arithmetic

    attr_accessor :code, :amount, :driver

    def initialize(amount, code, driver = nil)
      @amount     = amount
      @code       = code
      @driver     = driver
      @round      = 2
    end

    def convert_to(char_code, round = 2)
      raise NoDriverSettledError if @driver.nil?

      @round = round
      return self if self.code == char_code
      @driver.exchange(self, char_code, round)
    end

    def convert_list(char_codes, round = 2)
      char_codes.map do |char_code|
        convert_to(char_code, round)
      end
    end
  end
end
