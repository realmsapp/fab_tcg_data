# frozen_string_literal: true

module FabTcgData
  module PrintFinishes
    include Concerns::OptionList

    class PrintFinish
      include ValueSemantics.for_attributes {
        key String
        name String
        code Either(nil, String)
      }
    end

    ALL = Lookup.load("print_finishes.yaml") do |item|
      PrintFinish.new(
        key: item.fetch(:print_finish_key),
        name: item.fetch(:name),
        code: item.fetch(:code),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end
