require_relative "cbr_decorator"
require 'stringio'

module Xrates
  module Parser
    module Sax
      class Cbr

        def parse(xml)

          handler = CbrDecorator.new()
          Ox.sax_parse(
            handler,
            StringIO.new(xml)
          )
          handler.result
        end
      end
    end
  end
end