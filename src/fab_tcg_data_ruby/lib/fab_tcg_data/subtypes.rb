module FabTcgData
  module Subtypes
    class Subtype
      include ValueSemantics.for_attributes {
        key String
        name String
      }
    end

    ALL = Lookup.load("subtypes.yaml") do |item|
      Subtype.new(
        key: item.fetch(:subtype_key),
        name: item.fetch(:name),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end