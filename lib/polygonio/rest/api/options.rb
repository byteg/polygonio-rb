# frozen_string_literal: true

module Polygonio
  module Rest
    class Options < PolygonRestHandler
      class OptionChainSnapshotResponse < PolygonResponse
        attribute :results, Types::Array do
          attribute :break_even_price, Types::JSON::Decimal

          attribute :day do
            attribute :change, Types::JSON::Decimal
            attribute :change_percent, Types::JSON::Decimal
            attribute :close, Types::JSON::Decimal
            attribute :high, Types::JSON::Decimal
            attribute :low, Types::JSON::Decimal
            attribute :open, Types::JSON::Decimal
            attribute :previous_close, Types::JSON::Decimal
            attribute :volume, Types::JSON::Decimal
            attribute :vwap, Types::JSON::Decimal
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
            attribute :change_to_break_even, Types::JSON::Decimal
            attribute :last_updated, Types::Integer
            attribute :price, Types::JSON::Decimal
            attribute :ticker, Types::String
          end

          attribute? :last_quote do
            attribute :ask, Types::JSON::Decimal
            attribute :ask_size, Types::Integer
            attribute :bid, Types::JSON::Decimal
            attribute :bid_size, Types::Integer
            attribute :last_updated, Types::Integer
            attribute :midpoint, Types::JSON::Decimal
            attribute :timeframe, Types::String
          end
        end
      end

      def option_chain_snapshot(symbol)
        res = client.request.get("/v3/snapshot/options/#{symbol}")
        OptionChainSnapshotResponse[res.body]
      end

    end
  end
end
