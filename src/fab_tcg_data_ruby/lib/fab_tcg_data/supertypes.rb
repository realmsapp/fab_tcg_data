module FabTcgData
  module Supertypes
    include Concerns::OptionList

    class Supertype
      include ValueSemantics.for_attributes {
        key String
        name String
        class? Bool()
        element? Bool()
        talent? Bool()
      }
    end

    ALL = Lookup.load("supertypes.yaml") do |item|
      Supertype.new(
        key: item.fetch(:supertype_key),
        name: item.fetch(:name),
        class?: item.fetch(:is_class),
        element?: item.fetch(:is_element),
        talent?: item.fetch(:is_talent),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end