module FabTcgData
  module SetCards
    class SetCard
      include ValueSemantics.for_attributes {
        key String
        name String
        rarity Rarities::Rarity
        artist Artists::Artist
        card_type CardTypes::CardType
        supertypes ArrayOf(Supertypes::Supertype)
        subtypes ArrayOf(Subtypes::Subtype)

        game_text String
        flavor_text Either(String, nil), default: nil
        image_url String
        color_strip Either(String, nil), default: nil

        cost Either(String, nil), default: nil
        defense Either(String, nil), default: nil
        intellect Either(String, nil), default: nil
        life Either(String, nil), default: nil
      }
    end

    ALL = Lookup.load("set_cards/**/*.yaml") do |item|
      SetCard.new(
        key: item.fetch(:key),
        name: item.fetch(:name),
        rarity: Rarities.fetch(item.fetch(:rarity)),
        artist: Artists.fetch(item.fetch(:artist, "unknown")),
        card_type: CardTypes.fetch(item.fetch(:card_type)),
        supertypes: item.fetch(:supertypes, []).map { |stk| Supertypes.fetch(stk) },
        subtypes: item.fetch(:subtypes, []).map { |stk| Subtypes.fetch(stk) },
        game_text: item.fetch(:game_text),
        image_url: item.fetch(:image_url),

        color_strip: item.fetch(:color_strip, nil)&.to_s,
        intellect: item.fetch(:intellect, nil)&.to_s,
        life: item.fetch(:life, nil)&.to_s,
        cost: item.fetch(:cost, nil)&.to_s,
        defense: item.fetch(:defense, nil)&.to_s,
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end