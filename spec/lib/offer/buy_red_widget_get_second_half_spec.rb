require "spec_helper"

RSpec.describe AcmeBasket::Offer::BuyRedWidgetGetSecondHalf do
  let(:red) { AcmeBasket::Product.new(code: "R01", name: "Red", price: 32.95) }
  let(:green) { AcmeBasket::Product.new(code: "G01", name: "Green", price: 24.95) }
  subject { described_class.new }

  it "applies no discount with 0 or 1 red widget" do
    expect(subject.apply([])).to eq(0)
    expect(subject.apply([red])).to eq(0)
  end

  it "applies half price to 1 red when there are 2" do
    expect(subject.apply([red, red])).to eq(16.475)
  end

  it "applies half price only once when there are 3" do
    expect(subject.apply([red, red, red])).to eq(16.475)
  end

  it "applies discount twice when there are 4" do
    expect(subject.apply([red] * 4)).to eq(32.95)
  end

  it "ignores non-red widgets" do
    expect(subject.apply([green, red])).to eq(0)
  end

  it "includes correct marketing copy" do
    expect(subject.marketing_copy).to eq("Buy one red widget, get the second half price")
  end
end
