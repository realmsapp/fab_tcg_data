# frozen_string_literal: true

module FabTcgData
  module SetPrintings
    include Concerns::OptionList

    class SetPrinting
      include ValueSemantics.for_attributes {
        key String
        name String
        language String
      }

      def strategy
        @strategy ||= "FabTcgData::SetPrintings::#{key.underscore.classify}".constantize
      end

      def finishes_for(set_card)
        strategy.run(set_card)
      end
    end

    ALL = Lookup.load("set_printings.yaml") do |item|
      SetPrinting.new(
        key: item.fetch(:key),
        name: item.fetch(:name),
        language: item.fetch(:language),
      )
    end

    module UWtr
      def self.run(card)
        finishes = Set.new
        case card.rarity.key
        when "token"
          finishes.add(PrintFinishes.fetch("regular"))
        when "fabled", "legendary"
          finishes.add(PrintFinishes.fetch("rainbow_foil"))
        else
          finishes.add(PrintFinishes.fetch("regular"))
          finishes.add(PrintFinishes.fetch("rainbow_foil"))
        end
        finishes.to_a
      end
    end

    module Wtr
      def self.run(card)
        finishes = Set.new
        case card.rarity.key
        when "token"
          finishes.add(PrintFinishes.fetch("regular"))
        when "fabled", "legendary"
          finishes.add(PrintFinishes.fetch("cold_foil"))
        else
          finishes.add(PrintFinishes.fetch("regular"))
          finishes.add(PrintFinishes.fetch("rainbow_foil"))
        end
        finishes.to_a
      end
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
