# frozen_string_literal: true

require_relative "test_helper"

class TestFabTcgDataRuby < Minitest::Test
  def test_it_does_something_useful
    brute = FabTcgData::Supertypes.fetch("brute")
    assert brute.class?
  end
end
