require "spec_helper"

RSpec.describe AcmeBasket::Product do
  it "initializes with correct attributes" do
    product = described_class.new(code: "X01", name: "Xtreme", price: 10.5)
    expect(product.code).to eq("X01")
    expect(product.name).to eq("Xtreme")
    expect(product.price).to eq(10.5)
  end
end
