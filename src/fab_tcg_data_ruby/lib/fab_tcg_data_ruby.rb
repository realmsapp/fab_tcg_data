# frozen_string_literal: true

require "yaml"
require "value_semantics"
require "active_support"
require "active_support/core_ext"

require "fab_tcg_data/version"

require "fab_tcg_data/concerns"

require "fab_tcg_data/lookup"
require "fab_tcg_data/releases"
require "fab_tcg_data/sets"
require "fab_tcg_data/artists"
require "fab_tcg_data/print_finishes"
require "fab_tcg_data/print_features"
require "fab_tcg_data/rarities"
require "fab_tcg_data/card_types"
require "fab_tcg_data/supertypes"
require "fab_tcg_data/subtypes"
require "fab_tcg_data/keywords"
require "fab_tcg_data/set_cards"

module FabTcgData
  class Error < StandardError; end
end
