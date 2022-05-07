# frozen_string_literal: true

module FabTcgData
  module SetCards
    class SetCard
      def self.load(item)
        SetCard.new(
          key: item.fetch(:key),
          card_key: item.fetch(:name).gsub(/[^\p{L}]|[1-9]/, " ").squish.gsub(/\s/, "_").downcase,
          set: Sets.fetch(item.fetch(:key).slice(0...3)),

          rarity: Rarities.fetch(item.fetch(:rarity)),
          artist: Artists.fetch(item.fetch(:artist, "unknown")),
          image_url: item.fetch(:image_url),

          name: item.fetch(:name),
          card_type: CardTypes.fetch(item.fetch(:card_type)),
          supertypes: item.fetch(:supertypes, []).map { |stk| Supertypes.fetch(stk) },
          subtypes: item.fetch(:subtypes, []).map { |stk| Subtypes.fetch(stk) },

          attack: item.fetch(:attack, nil),
          cost: item.fetch(:cost, nil),
          defense: item.fetch(:defense, nil),
          intellect: item.fetch(:intellect, nil),
          life: item.fetch(:life, nil),
          resources: item.fetch(:resources, nil),

          game_text: item.fetch(:game_text, nil),
          flavor_text: item.fetch(:flavor_text, nil),

          keywords: item.fetch(:keywords, []).map { |k| Keywords.fetch(k) },
          essences: item.fetch(:essences, []).map { |k| Supertypes.fetch(k) },
          legendary?: item.fetch(:legendary, false),
          specialization: item.fetch(:specialization, "none"),

          print_finishes: item.fetch(:print_feature_keys, []),
          print_features: item.fetch(:print_finish_keys, []),
        )
      end

      include ValueSemantics.for_attributes {
        key String
        card_key String
        name String

        set Sets::Set
        rarity Rarities::Rarity
        artist Artists::Artist
        image_url Either(String, nil), default: nil

        # Card attributes
        card_type CardTypes::CardType
        supertypes ArrayOf(Supertypes::Supertype), default: []
        subtypes ArrayOf(Subtypes::Subtype), default: []

        # Stats
        attack Either(String, nil), default: nil
        cost Either(String, nil), default: nil
        defense Either(String, nil), default: nil
        intellect Either(String, nil), default: nil
        life Either(String, nil), default: nil
        resources Either(String, nil), default: nil

        # Text
        game_text Either(String, nil), default: nil
        flavor_text Either(String, nil), default: nil

        # deckbuilding
        keywords ArrayOf(Keywords::Keyword), default: []
        essences ArrayOf(Supertypes::Supertype), default: []
        legendary? Bool(), default: false
        specialization String, default: nil # TODO

        # Printing
        print_finishes ArrayOf(PrintFinishes::PrintFinish), default: []
        print_features ArrayOf(PrintFeatures::PrintFeature), default: []
      }

      def attributes
        {
          key:,
          card_key:,
          name:,
          set: set.key,
          rarity: rarity.key,
          artist: artist.key,
          image_url:,
          card_type: card_type.key,
          supertypes: supertypes.map(&:key),
          subtypes: subtypes.map(&:key),
          resources:,
          cost:,
          attack:,
          defense:,
          intellect:,
          life:,
          game_text:,
          flavor_text:,
          keywords: keywords.map(&:key),
          essences: essences.map(&:key),
          legendary?: legendary?,
          specialization:,
          print_finishes: print_finishes.map(&:key),
          print_features: print_features.map(&:key),
        }.reject { |_a, b| b.blank? }.to_h
      end
    end

    ALL = Lookup.load("set_cards/**/*.yaml") do |item|
      SetCard.load(item)
    rescue StandardError => e
      raise ParseError, item.inspect
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
