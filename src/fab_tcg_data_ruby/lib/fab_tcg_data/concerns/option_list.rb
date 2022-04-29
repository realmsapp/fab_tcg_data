module FabTcgData
  module Concerns
    module OptionList
      extend ActiveSupport::Concern

      class_methods do
        def to_option_list(&block)
          items = self::ALL
          items = items.select(&block) if block_given?
          items = items.map { |_, thing| [thing.name, thing.key] }
          items.sort_by { |a, _| a }
        end
      end
    end
  end
end