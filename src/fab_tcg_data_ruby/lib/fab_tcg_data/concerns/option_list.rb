module FabTcgData
  module Concerns
    module OptionList
      extend ActiveSupport::Concern

      class_methods do
        def to_option_list(&block)
          items = self::ALL.values
          items = items.select(&block) if block_given?
          items = items.map { |thing| [thing.name, thing.key] }
          items.sort_by { |a, _| a }
        end

        def to_grouped_option_list(&block)
          items = self::ALL.values.group_by(&block).transform_values { |things| things.map { |thing| [thing.name, thing.key] }}
          items.sort_by { |a, _| a }
        end
      end
    end
  end
end