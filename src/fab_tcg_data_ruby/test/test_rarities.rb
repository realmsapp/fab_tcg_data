# frozen_string_literal: true

require_relative "test_helper"

class TestRarities < Minitest::Test
  def test_to_option_list
    options = FabTcgData::Rarities.to_option_list
    assert_equal ["Common", "common"], options[0]
  end

  def test_to_grouped_option_list
    options = FabTcgData::Rarities.to_grouped_option_list(&:name)
    assert_equal ["Common", "common"], options[0]
  end
end