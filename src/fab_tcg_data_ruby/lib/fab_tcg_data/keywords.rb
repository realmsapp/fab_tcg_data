# frozen_string_literal: true

module FabTcgData
  module Keywords
    include Concerns::OptionList

    class Keyword
      include ValueSemantics.for_attributes {
        key String
        name String
        description String
      }
    end

    ALL = Lookup.load("keywords.yaml") do |item|
      Keyword.new(
        key: item.fetch(:keyword_key),
        name: item.fetch(:name),
        description: item.fetch(:description),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
