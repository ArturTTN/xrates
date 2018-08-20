#https://www.cbr.ru
module Xrates
  module Config
    class Cbr

      extend Xrates::Config

      # endpoint API url
      # @return [String]
      attr_accessor :endpoint

      # parser class
      # @return [Class]
      attr_accessor :parser

      # cache
      # @return [Class]
      attr_accessor :cache

      def initialize

        @endpoint = "https://www.cbr.ru/scripts/xml_daily.asp"
        @parser   = Xrates::Parser::Sax::Cbr
        @cache    = Xrates::Cache::RedisStore
      end
    end
  end
end
