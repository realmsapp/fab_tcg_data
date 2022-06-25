# frozen_string_literal: true

RSpec.describe FabTcgData::SetCards::Variant do
  it "works" do
    set_card = FabTcgData::SetCards.fetch("WTR000")
    expect(set_card.name).to eq("Heart of Fyendal")
    expect(set_card.variants.length).to eq(2)
    expect(set_card.variants.map(&:key)).to contain_exactly(
      "U-WTR-WTR000-RF",
      "WTR-WTR000-CF"
    )
  end
end
