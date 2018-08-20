module Xrates
  module Config
    module Storage
      class File

        extend Xrates::Config

        # folder
        # @return [String]
        attr_accessor :folder

        def initialize
          @folder = "/tmp"
        end

      end
    end
  end
end