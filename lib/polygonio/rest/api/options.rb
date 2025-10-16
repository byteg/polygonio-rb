# frozen_string_literal: true

module Polygonio
  module Rest
    class Options < PolygonRestHandler
      class OptionChainSnapshotResponse < PolygonResponse
        attribute :results, Types::Array do
          attribute :break_even_price, Types::JSON::Decimal

          attribute :day do
            attribute? :change, Types::JSON::Decimal
            attribute? :change_percent, Types::JSON::Decimal
            attribute? :close, Types::JSON::Decimal
            attribute? :high, Types::JSON::Decimal
            attribute?  :low, Types::JSON::Decimal
            attribute? :open, Types::JSON::Decimal
            attribute? :previous_close, Types::JSON::Decimal
            attribute? :volume, Types::JSON::Decimal
            attribute? :vwap, Types::JSON::Decimal
          end

          attribute :details do
            attribute :contract_type, Types::String
            attribute :expiration_date, Types::JSON::Date
            attribute :shares_per_contract, Types::Integer
            attribute :strike_price, Types::JSON::Decimal
            attribute :ticker, Types::String
          end

          attribute :greeks do
            attribute? :delta, Types::JSON::Decimal
            attribute? :gamma, Types::JSON::Decimal
            attribute? :theta, Types::JSON::Decimal
            attribute? :vega, Types::JSON::Decimal
          end

          attribute? :implied_volatility, Types::JSON::Decimal
          attribute? :open_interest, Types::JSON::Decimal

          attribute :underlying_asset do
            attribute? :change_to_break_even, Types::JSON::Decimal
            attribute? :last_updated, Types::Integer
            attribute? :price, Types::JSON::Decimal
            attribute? :ticker, Types::String
          end

          attribute? :last_quote do
            attribute? :ask, Types::JSON::Decimal
            attribute? :ask_size, Types::Integer
            attribute? :bid, Types::JSON::Decimal
            attribute? :bid_size, Types::Integer
            attribute? :last_updated, Types::Integer
            attribute? :midpoint, Types::JSON::Decimal
            attribute? :timeframe, Types::String
          end
        end

        attribute? :next_url, Types::String
      end

      def option_chain_snapshot(symbol, limit: 10, next_url: nil)
        url = next_url || "/v3/snapshot/options/#{symbol}?limit=#{limit}"
        res = client.request.get(url)
        OptionChainSnapshotResponse[res.body]
      end

      class AllOptionsResponse < PolygonResponse
        attribute :results, Types::Array do
          attribute :cfi, Types::String
          attribute :contract_type, Types::String
          attribute :exercise_style, Types::String
          attribute :expiration_date, Types::JSON::Date
          attribute :primary_exchange, Types::String
          attribute :shares_per_contract, Types::Integer
          attribute :strike_price, Types::JSON::Decimal
          attribute :ticker, Types::String
          attribute :underlying_ticker, Types::String

          attribute :additional_underlyings, Types::Array do
            attribute :amount, Types::Integer
            attribute :underlying, Types::String
            attribute :type, Types::String
          end
        end

        attribute? :next_url, Types::String
      end

      def all_options(symbol, limit: 10, next_url: nil)
        url = next_url || "/v3/reference/options/contracts?underlying_ticker=#{symbol}&limit=#{limit}"
        res = client.request.get(url)
        AllOptionsResponse[res.body]
      end
    end
  end
end
