#https://fixer.io
module Xrates
  module Config
    class Fixer

      extend Xrates::Config

      # endpoint API url
      # @return [String]
      attr_accessor :endpoint

      # endpoint access key
      # @return [String]
      attr_accessor :access_key

      # parser class
      # @return [Class]
      attr_accessor :parser

      # cache
      # @return [Class]
      attr_accessor :cache

      def initialize

        @access_key = "568ce8a8fe8bb805ab5b84e2ce2a47c8"
        @endpoint   = "http://data.fixer.io/api"
        @parser     = Xrates::Parser::Json::Fixer
        @cache      = Xrates::Cache::FileStore
      end
    end
  end
end
