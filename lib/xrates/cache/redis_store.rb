require "redis"
require "json"

module Xrates
  module Cache
    class RedisStore < Store

      attr_accessor :config

      def initialize(config = Xrates::Config::Storage::Redis.configuration)
        @config = config
        @client = Redis.new(url: "redis://:#{@config.pwd}@#{@config.endpoint}/#{@config.db}")
      end

      def get(key)
        #TODO: error handling
        JSON.parse(@client.get(key)) rescue nil
      end

      def set(key, value)
        @client.setex(key, @config.ttl, value.to_json)
      end
    end
  end
end