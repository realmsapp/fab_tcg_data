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
    end

    ALL = Lookup.load("set_printings.yaml") do |item|
      SetPrinting.new(
        key: item.fetch(:key),
        name: item.fetch(:name),
        language: item.fetch(:language),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
