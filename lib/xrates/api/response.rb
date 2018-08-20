module Xrates
  module Api
    class Response

      def initialize(response)
        @response = response
      end

      def body
        @response.body
      end
    end
  end
end