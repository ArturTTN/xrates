require 'ox'

module Xrates
  module Parser
    module Sax
      class CbrDecorator < ::Ox::Sax

        def initialize()
          @rates      = {}
          @currency   = {}
          @parent_tag = ""
          @char_code  = ""
        end

        def result()
          @rates
        end

        def start_element(name)

          @parent_tag = name

          case name
            when :Valute
              @currency = {}
          end
        end

        def end_element(name)

          case name
            when :Valute
              @rates.merge!(@currency)
          end
        end

        def text(value)

          case @parent_tag
            when :CharCode
              @char_code = value
              @currency[@char_code] = {}
            when :Nominal
              @currency[@char_code]["nominal"] = value.to_i
            when :Value
              @currency[@char_code]["value"] = value.gsub(",",".").to_f
          end
        end
      end
    end
  end
end