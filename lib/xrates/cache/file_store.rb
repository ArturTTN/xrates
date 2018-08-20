require "json"

module Xrates
  module Cache
    class FileStore < Store

      attr_accessor :config

      def initialize(config = Xrates::Config::Storage::File.configuration)
        @config = config
      end

      def get(key)
        #TODO: error handling
        JSON.parse(File.read(file_name(key))) rescue nil
      end

      def set(key, value)
        #TODO: error handling
        File.write(file_name(key), value.to_json) rescue {}
      end

      def file_name(key)
        file_name = "#{@config.folder}/#{key}.txt"
      end
    end
  end
end