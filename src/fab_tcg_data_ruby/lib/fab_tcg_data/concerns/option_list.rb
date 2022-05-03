# frozen_string_literal: true

module FabTcgData
  module Concerns
    module OptionList
      extend ActiveSupport::Concern

      class_methods do
        def to_option_list(&)
          items = self::ALL.values
          items = items.select(&) if block
          items = items.map { |thing| [thing.name, thing.key] }
          items.sort_by { |a, _| a }
        end

        def to_grouped_option_list(&)
          items = self::ALL.values.group_by(&).transform_values { |things| things.map { |thing| [thing.name, thing.key] } }
          items.sort_by { |a, _| a }
        end
      end
    end
  end
end
