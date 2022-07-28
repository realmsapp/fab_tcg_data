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

    module Upr
      def self.run(card)
        finishes = Set.new

        if ["fabled", "legendary"].include?(card.rarity.key)
          finishes.add(PrintFinishes.fetch("rainbow_foil"))
          finishes.add(PrintFinishes.fetch("cold_foil"))
        elsif card.card_type.key == "weapon"
          finishes.add(PrintFinishes.fetch("regular"))
          finishes.add(PrintFinishes.fetch("rainbow_foil"))
          finishes.add(PrintFinishes.fetch("cold_foil"))
        else
          case card.name
          when /\AInvoke ./
            finishes.add(PrintFinishes.fetch("regular"))
            finishes.add(PrintFinishes.fetch("marvel"))
          when "Phoenix Form", "Flamecall Awakening", "Inflame", "Stoke the Flames"
            finishes.add(PrintFinishes.fetch("regular"))
            finishes.add(PrintFinishes.fetch("rainbow_foil"))
            finishes.add(PrintFinishes.fetch("rainbow_foil_extended_art"))
          when "Phoenix Flame", "Iyslander"
            finishes.add(PrintFinishes.fetch("regular"))
            finishes.add(PrintFinishes.fetch("marvel"))
          when "Ash", "Aether Ashwing"
            finishes.add(PrintFinishes.fetch("regular"))
            finishes.add(PrintFinishes.fetch("cold_foil"))
            finishes.add(PrintFinishes.fetch("marvel"))
          when "Rewind"
            finishes.add(PrintFinishes.fetch("regular"))
            finishes.add(PrintFinishes.fetch("rainbow_foil"))
            finishes.add(PrintFinishes.fetch("rainbow_foil_alternate_art"))
          when "Scar for a Scar", "Cracked Bauble", "Dragons of Legend"
            finishes.add(PrintFinishes.fetch("regular"))
          else
            finishes.add(PrintFinishes.fetch("regular"))
            finishes.add(PrintFinishes.fetch("rainbow_foil"))
          end
        end

        finishes.to_a
      end
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
