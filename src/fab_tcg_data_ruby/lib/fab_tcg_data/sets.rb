# frozen_string_literal: true

module FabTcgData
  module Sets
    include Concerns::OptionList

    class Set
      include ValueSemantics.for_attributes {
        key String
        name String
        kind String
        release_key String
        printings ArrayOf(SetPrintings::SetPrinting), default: []
      }
    end

    ALL = Lookup.load("sets.yaml") do |item|
      Set.new(
        key: item.fetch(:set_key),
        name: item.fetch(:name),
        kind: item.fetch(:kind),
        release_key: item.fetch(:release_key),
        printings: item.fetch(:printing_keys, []).map do |printing_key|
          SetPrintings.fetch(printing_key)
        end
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
