# frozen_string_literal: true

RSpec.describe FabTcgData::Concerns::OptionList do
  it "makes helpful option lists" do
    options = FabTcgData::Rarities.to_option_list
    expect(options[0]).to eq(["Common", "common"])

    options = FabTcgData::Rarities.to_grouped_option_list(&:name)
    expect(options[0]).to eq(["Common", [["Common", "common"]]])
  end
end