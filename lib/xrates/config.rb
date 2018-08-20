require_relative "config/cbr"
require_relative "config/fixer"
require_relative "config/storage/file"
require_relative "config/storage/redis"
require_relative "parser/sax/cbr"
require_relative "parser/json/cbr"
require_relative "parser/json/fixer"
require_relative "api/client"
require_relative "api/response"

module Xrates
  module Config

    def configuration
      @config ||= self.new
    end

    def configuration=(config)
      @config = config
    end

    def configure
      yield configuration
    end
  end
end