module FabTcgData
  module PrintFinishes
    include Concerns::OptionList

    class PrintFinish
      include ValueSemantics.for_attributes {
        key String
        name String
      }
    end

    ALL = Lookup.load("print_finishes.yaml") do |item|
      PrintFinish.new(
        key: item.fetch(:print_finish_key),
        name: item.fetch(:name),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end