module Xrates
  module Parser
    module Json
      class Cbr

        def parse(json)
          Hash[
            json!(json).map{|currency, rate|
              [currency,
                {
                  "nominal" => rate["Nominal"],
                  "value" => rate["Value"]
                }
              ]
            }
          ]
        end

        def json!(json)
          #TODO: error handling
          JSON.parse(json)["Valute"] rescue {}
        end
      end
    end
  end
end