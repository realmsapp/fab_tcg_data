module FabTcgData
  module Keywords
    class Keyword
      include ValueSemantics.for_attributes {
        key String
        name String
        description String
      }
    end

    ALL = Lookup.load("keywords.yaml") do |item|
      Keyword.new(
        key: item.fetch(:rarity_key),
        name: item.fetch(:name),
        description: item.fetch(:description),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end