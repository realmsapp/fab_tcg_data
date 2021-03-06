# frozen_string_literal: true

module FabTcgData
  module SetCards
    class Persona
      include ValueSemantics.for_attributes {
        key
      }
    end

    class Variant
      def self.load(set_card_key, key)
        printing = SetPrintings::ALL.values.find do |sp|
          key.starts_with?(sp.key)
        end
        finish = PrintFinishes::ALL.values.find(-> { PrintFinishes.fetch("regular") }) do |f|
          key.ends_with?("-#{f.code}")
        end
        Variant.new(set_card_key:, finish:, printing:)
      end

      include ValueSemantics.for_attributes {
        set_card_key
        printing
        finish
      }

      def key
        @key ||= [
          [printing.key, set_card_key.slice(3..)].compact.join,
          finish.code,
        ].compact.join("-")
      end
    end

    class SetCard
      def self.load(item)
        SetCard.new(
          key: item.fetch(:key),
          back_key: item.fetch(:back_key, nil),
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
          specializations: item.fetch(:specializations) do
            Array.wrap(item.fetch(:specialization, []))
          end.map { |k| Persona.new(key: k) },
          variants: item.fetch(:variants, []).map { |k| Variant.load(item.fetch(:key), k) },
        )
      end

      include ValueSemantics.for_attributes {
        key String
        back_key Either(String, nil), default: nil
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
        specializations ArrayOf(Persona), default: []

        # Printing
        variants ArrayOf(Variant), default: []
      }

      def talents
        supertypes.select(&:talent?)
      end

      def hero_class
        supertypes.select(&:class?)
      end

      def back?
        @back ||= set_card_key.ends_with?("-BACK")
      end

      def name_slug
        @name_slug ||= name.gsub(/[^\p{L}]|[1-9]/, " ").squish.gsub(/\s/, "_").downcase
      end

      def color
        @color ||= {
          "3" => "blue",
          "2" => "yellow",
          "1" => "red",
        }.fetch(resources, nil)
      end

      def card_key
        @card_key ||= [name_slug, color].compact.join("-")
      end

      def selection_range(format: nil)
        return (0..1) if legendary?
        case card_type
        when CardTypes::WEAPON then (0..1)
        when CardTypes::HERO then (0..1)
        when CardTypes::EQUIPMENT then (0..1)
        else
          if ["blitz", "commoner"].include?(format)
            (0..2)
          else
            (0..3)
          end
        end
      end

      def attributes
        {
          key:,
          card_key:,
          back_key:,
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
          legendary: legendary?,
          specializations: specializations.map(&:key),
          variants: variants.map(&:key),
        }.reject { |_a, b| b.blank? }.to_h
      end

      def printed_variants
        set.printings.each_with_object([]) do |printing, memo|
          printing.finishes_for(self).each do |finish|
            memo << Variant.new(set_card_key: key, finish:, printing:)
          end
        end
      end

      def to_realms_yaml
        data = attributes
        data[:game_text] = LiteralScalar.new(data[:game_text].delete("\r")) if data[:game_text].present?
        data[:flavor_text] = LiteralScalar.new(data[:flavor_text]) if data[:flavor_text].present?
        data.delete(:card_key)
        YAML.dump(data.stringify_keys)
      end

      class LiteralScalar
        attr_reader :str

        def initialize(str)
          @str = str
        end

        def blank?
          str.blank?
        end

        def encode_with(coder)
          coder.style = Psych::Nodes::Scalar::LITERAL
          coder.scalar = str
          coder.tag = nil
        end
      end
    end

    def self.fetch(key)
      _cache.fetch(key) do
        set_card = nil
        Lookup.load("set_cards/**/#{key}.yaml") do |item|
          begin
            set_card = SetCard.load(item)
          rescue StandardError => e
            raise ParseError, item.inspect
          end
          _cache[key] = set_card
        end
        set_card
      end
    end

    def self._cache
      @_cache ||= {}
    end
  end
end
