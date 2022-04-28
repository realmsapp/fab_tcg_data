# frozen_string_literal: true

require_relative "test_helper"

class TestFabTcgDataRuby < Minitest::Test
  def test_it_does_something_useful
    set_card = FabTcgData::SetCards.fetch("UPR102")
    assert "Iyslander, Stormbind", set_card.name
  end
end
