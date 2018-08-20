require 'net/http'

module Xrates
  module Api
    class Client

      def initialize(endpoint, timeout = 5)
        @endpoint = endpoint
        @headers = {}
        @timeout = timeout
      end

      def set_headers(hash)
        @headers = @headers.merge(hash)
      end

      def request(method, options = {})

        response    = nil
        path        = URI(@endpoint)

        begin
          case method
            when :get
              response = get(path, options)
            when :post
              #TODO: post if needed
              response = post(path, options)
          end
        rescue Exception => e
          #TODO: handle error reporting
          raise e
        end

        return Response.new(response)
      end

      def get(path, opts)
        path.query  = URI.encode_www_form(opts)
        Net::HTTP.get_response(path)
      end

      def post(path, opts)
        #TODO: if needed
      end
    end
  end
end