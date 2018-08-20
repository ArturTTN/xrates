module Xrates
  module Cache
    class Store
      def get; raise NotImplementedError, "Implement this method in a child class" end
      def set; raise NotImplementedError, "Implement this method in a child class" end
    end
  end
end