# frozen_string_literal: true

RSpec.describe FabTcgData::SetCards::Variant do
  context "WTR Set - given fabled card" do
    it "is typically available as CF in alpha and RF in Unlimited" do
      set_card = FabTcgData::SetCards.fetch("WTR000")
      expect(set_card.name).to eq("Heart of Fyendal")
      expect(set_card.variants.length).to eq(2)
      expect(set_card.variants.map(&:key)).to contain_exactly(
        "U-WTR000-RF",
        "WTR000-CF",
      )
    end
  end

  context "WTR Set - given common card" do
    it "is typically available as CF in alpha and RF in Unlimited" do
      set_card = FabTcgData::SetCards.fetch("WTR100")
      expect(set_card.name).to eq("Head Jab")
      expect(set_card.card_key).to eq("head_jab-blue")
      expect(set_card.variants.map(&:key)).to contain_exactly("U-WTR100", "U-WTR100-RF", "WTR100", "WTR100-RF")
    end
  end
end
