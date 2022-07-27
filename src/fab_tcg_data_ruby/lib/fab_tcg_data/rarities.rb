# frozen_string_literal: true

module FabTcgData
  module Rarities
    include Concerns::OptionList

    class Rarity
      include ValueSemantics.for_attributes {
        key String
        name String
        symbol String
      }

      def color
        "purple"
      end
    end

    ALL = Lookup.load("rarities.yaml") do |item|
      Rarity.new(
        key: item.fetch(:rarity_key),
        name: item.fetch(:name),
        symbol: item.fetch(:symbol),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
