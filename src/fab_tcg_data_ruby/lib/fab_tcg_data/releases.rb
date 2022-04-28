module FabTcgData
  module Releases
    class Release
      include ValueSemantics.for_attributes {
        key String
        name String
        release_date Date
      }
    end

    ALL = Lookup.load("releases.yaml") do |item|
      Release.new(
        key: item.fetch(:key),
        name: item.fetch(:name),
        release_date: item.fetch(:release_date),
      )
    end

    def self.fetch(key, *args) = ALL.fetch(key, *args)
  end
end