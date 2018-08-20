module Xrates
  module Parser
    module Json
      class Fixer

        def parse(json)
          Hash[
            json!(json).map{|currency, rate|
              [currency,
                {
                  "nominal" => 1,
                  "value" => rate
                }
              ]
            }
          ]
        end

        def json!(json)
          #TODO: error handling
          JSON.parse(json)["rates"] rescue {}
        end
      end
    end
  end
end