# frozen_string_literal: true

module FabTcgData
  module PrintFeatures
    include Concerns::OptionList

    class PrintFeature
      include ValueSemantics.for_attributes {
        key String
        name String
      }
    end

    ALL = Lookup.load("print_features.yaml") do |item|
      PrintFeature.new(
        key: item.fetch(:print_feature_key),
        name: item.fetch(:name),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
