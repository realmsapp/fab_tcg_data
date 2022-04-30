module FabTcgData
  module CardTypes
    include Concerns::OptionList

    class CardType
      include ValueSemantics.for_attributes {
        key String
        name String
      }
    end

    ALL = Lookup.load("card_types.yaml") do |item|
      CardType.new(
        key: item.fetch(:card_type_key),
        name: item.fetch(:name),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end