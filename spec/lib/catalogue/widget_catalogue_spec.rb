require "spec_helper"

RSpec.describe AcmeBasket::Catalogue::WidgetCatalogue do
  subject { described_class.new }

  it "finds a product by code" do
    expect(subject.find("R01").name).to eq("Red Widget")
    expect(subject.find("B01").name).to eq("Blue Widget")
    expect(subject.find("G01").name).to eq("Green Widget")
  end

  it "returns nil for unknown code" do
    expect(subject.find("Z")).to be_nil
  end
end
