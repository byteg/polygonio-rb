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

      def all_contracts(last_trade_date_gte: nil, next_url: nil)
        if next_url.present?
          url = next_url
        else
          url = "/futures/v1/contracts?active=true"
          if last_trade_date_gte.present?
            url += "&last_trade_date.gte=#{last_trade_date_gte}"
          end
        end
        res = client.request.get(url)
        AllContractsResponse[res.body]
      end

      class AllProductsResponse < PolygonResponse
        attribute? :next_url, Types::String

        attribute :results, Types::Array do
          attribute? :asset_class, Types::String
          attribute? :asset_sub_class, Types::String
          attribute? :date, Types::JSON::Date
          attribute? :last_updated, Types::String
          attribute :name, Types::String
          attribute? :price_quotation, Types::String
          attribute? :product_code, Types::String
          attribute? :sector, Types::String
          attribute? :settlement_currency_code, Types::String
          attribute? :settlement_method, Types::String
          attribute? :settlement_type, Types::String
          attribute? :sub_sector, Types::String
          attribute :trade_currency_code, Types::String
          attribute? :trading_venue, Types::String
          attribute? :type, Types::String
          attribute? :unit_of_measure, Types::String
          attribute? :unit_of_measure_qty, Types::Integer
        end
      end

      def all_products(next_url: nil)
        if next_url.present?
          url = next_url
        else
          url = "/futures/v1/products"
        end
        res = client.request.get(url)
        AllProductsResponse[res.body]
      end
    end
  end
end
