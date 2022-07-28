# frozen_string_literal: true

RSpec.describe FabTcgData::SetCards do
  it "works" do
    set_card = FabTcgData::SetCards.fetch("UPR102")
    expect(set_card.name).to eq("Iyslander, Stormbind")
  end

  describe "#to_realms_yaml" do
    it "dumps and loads" do
      set_card = FabTcgData::SetCards.fetch("UPR102")
      loaded = FabTcgData::SetCards::SetCard.load(YAML.load(set_card.to_realms_yaml).symbolize_keys)
      expect(set_card).to eq(loaded)
    end
  end
end
