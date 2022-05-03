# frozen_string_literal: true

RSpec.describe FabTcgData::SetCards do
  it "works" do
    set_card = FabTcgData::SetCards.fetch("UPR102")
    expect(set_card.name).to eq("Iyslander, Stormbind")
  end
end
