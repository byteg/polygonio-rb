# frozen_string_literal: true

module Polygonio
  module Rest
    class Futures < PolygonRestHandler
      class AllContractsResponse < PolygonResponse
        attribute? :next_url, Types::String

        attribute :results, Types::Array do
          attribute :active, Types::Bool
          attribute :date, Types::JSON::Date
          attribute? :days_to_maturity, Types::Integer
          attribute? :first_trade_date, Types::JSON::Date
          attribute :group_code, Types::String
          attribute? :last_trade_date, Types::JSON::Date
          attribute? :max_order_quantity, Types::Integer
          attribute? :min_order_quantity, Types::Integer
          attribute :name, Types::String
          attribute :product_code, Types::String
          attribute? :settlement_date, Types::JSON::Date
          attribute? :settlement_tick_size, Types::JSON::Decimal
          attribute? :spread_tick_size, Types::JSON::Decimal
          attribute :ticker, Types::String
          attribute? :trade_tick_size, Types::JSON::Decimal
          attribute? :trading_venue, Types::String
          attribute? :type, Types::String
        end
      end

      def all_contracts(next_url: nil)
        if next_url.present?
          url = next_url
        else
          url = "/futures/v1/contracts"
        end
        res = client.request.get(url)
        AllContractsResponse[res.body]
      end
    end
  end
end
