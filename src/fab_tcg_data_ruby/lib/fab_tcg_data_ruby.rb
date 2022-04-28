# frozen_string_literal: true

require "yaml"
require "value_semantics"
require "active_support"
require "active_support/core_ext"
require "fab_tcg_data/version"
require "fab_tcg_data/lookup"
require "fab_tcg_data/supertypes"

module FabTcgData
  class Error < StandardError; end
end
