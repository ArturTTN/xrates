module Xrates
  module Config
    module Storage
      class Redis

        extend Xrates::Config

        # endpoint API url
        # @return [String]
        attr_accessor :endpoint

        # db name
        # @return [String]
        attr_accessor :db

        # ttl for expiration
        # @return [String]
        attr_accessor :ttl

        # pwd password for redis connection
        # @return [String]
        attr_accessor :pwd

        def initialize

          @endpoint = "redis-15531.c55.eu-central-1-1.ec2.cloud.redislabs.com:15531"
          @db       = "xrates"
          @ttl      = 24*60*60
          @pwd      = "Ageoqv4sWNySDbkosD8jtQ5DfqJJF2Kf"
        end
      end
    end
  end
end