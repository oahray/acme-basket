require "spec_helper"

RSpec.describe AcmeBasket::Catalogue::Base do
  let(:products) do
    [
      { code: "A", name: "Alpha", price: 5.0 },
      { code: "B", name: "Beta", price: 10.0 }
    ]
  end

  subject { described_class.new(products) }

  it "finds a product by code" do
    expect(subject.find("A").name).to eq("Alpha")
  end

  it "returns nil for unknown code" do
    expect(subject.find("Z")).to be_nil
  end
end
