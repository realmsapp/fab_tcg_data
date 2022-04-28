require "date"

module FabTcgData
  class Lookup
    def self.root_path
      @root_path ||= Gem::Specification.find_by_name("fab_tcg_data_ruby").gem_dir
    end

    def self.load(glob, &)
      Dir[File.join(root_path, "data/", glob)].each_with_object({}) do |path, memo|
        YAML.safe_load(File.read(path)).each do |attributes|
          item = yield(attributes.transform_keys(&:to_sym))
          memo[item.key] = item
        end
      end
    end
  end
end