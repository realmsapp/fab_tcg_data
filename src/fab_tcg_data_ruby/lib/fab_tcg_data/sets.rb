module FabTcgData
  module Sets
    class Set
      include ValueSemantics.for_attributes {
        key String
        name String
        release_key String
      }
    end

    ALL = Lookup.load("sets.yaml") do |item|
      Set.new(
        key: item.fetch(:set_key),
        name: item.fetch(:name),
        release_key: item.fetch(:release_key),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end