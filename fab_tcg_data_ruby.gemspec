# frozen_string_literal: true

require_relative "lib/fab_tcg_data/version"

Gem::Specification.new do |spec|
  spec.name = "fab_tcg_data_ruby"
  spec.version = FabTcgData::VERSION
  spec.authors = ["realmsapp"]
  spec.email = ["realmsapp@protonmail.com"]

  spec.summary = "a ruby client for interacting with the fab_tcg_data repository"
  spec.homepage = "https://github.com/realmsapp/fab_tcg_data"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/realmsapp/fab_tcg_data"
  spec.metadata["changelog_uri"] = "https://github.com/realmsapp/fab_tcg_data/CHANGELOG.md"

  spec.files = Dir["data/**/*", "LICENSE", "README.md", "fab_tcg_data_ruby.gemspec", "src/fab_tcg_data_ruby/**/*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "value_semantics"
  spec.add_dependency "activesupport"
end
