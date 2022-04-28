module FabTcgData
  module Artists
    class Artist
      include ValueSemantics.for_attributes {
        key String
        name String
      }
    end

    ALL = Lookup.load("artists.yaml") do |item|
      Artist.new(
        key: item.fetch(:key),
        name: item.fetch(:name),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end