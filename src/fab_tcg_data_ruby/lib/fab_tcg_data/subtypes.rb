# frozen_string_literal: true

module FabTcgData
  module Subtypes
    include Concerns::OptionList

    class Subtype
      include ValueSemantics.for_attributes {
        key String
        name String
      }
    end

    ALL = Lookup.load("subtypes.yaml") do |item|
      Subtype.new(
        key: item.fetch(:key),
        name: item.fetch(:name),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
