require "spec_helper"

RSpec.describe AcmeBasket::Basket do
  let(:offers) { [AcmeBasket::Offer::BuyRedWidgetGetSecondHalf.new] }
  subject { described_class.new(offers: offers) }

  describe "#add" do
    it "adds products by code" do
      expect { subject.add("R01") }.to change { subject.instance_variable_get(:@items).size }.by(1)
    end

    it "raises error for unknown product" do
      expect { subject.add("X99") }.to raise_error("Unknown product: X99")
    end

    context "with quantity included" do
      it "raises error if quantity is not positive" do
        expect { subject.add("R01", -2) }.to raise_error(ArgumentError)
      end

      it "does not add the item when quantity is zero" do
        expect { subject.add("R01", 0) }.not_to change { subject.instance_variable_get(:@items).size }
      end

      it "adds multiple items when quantity is specified" do
        expect { subject.add("R01", 3) }.to change { subject.instance_variable_get(:@items).count { |p| p.code == "R01" } }.by(3)
      end

      it "defaults quantity to 1 if not specified" do
        expect { subject.add("G01") }.to change { subject.instance_variable_get(:@items).count { |p| p.code == "G01" } }.by(1)
      end
    end
  end

  describe "#remove" do
    before { 5.times { subject.add("B01") } }

    it "raises error if quantity is not positive" do
      expect { subject.remove("B01", -2) }.to raise_error(ArgumentError)
    end

    it "removes the specified number of items" do
      expect { subject.remove("B01", 3) }.to change { subject.instance_variable_get(:@items).count { |p| p.code == "B01" } }.by(-3)
    end

    it "removes only one unit if quantity is not included" do
      expect { subject.remove("B01") }.to change { subject.instance_variable_get(:@items).count { |p| p.code == "B01" } }.by(-1)
    end

    it "removes all if quantity exceeds item count in basket" do
      expect { subject.remove("B01", 10) }.to change { subject.instance_variable_get(:@items).count { |p| p.code == "B01" } }.by(-5)
    end
  end

  describe "#clear" do
    it "empties the basket" do
      subject.add("R01", 2)
      subject.add("G01", 1)
      subject.clear!
      expect(subject.instance_variable_get(:@items)).to be_empty
    end
  end

  describe "#items" do
    it "returns a summary of items in the basket with code, name, and quantity" do
      subject.add("R01", 2)
      subject.add("G01")
      expect(subject.items).to contain_exactly(
        { code: "R01", name: "Red Widget", quantity: 2 },
        { code: "G01", name: "Green Widget", quantity: 1 }
      )
    end

    it "returns an empty array when basket is empty" do
      expect(subject.items).to eq([])
    end
  end

  describe "#total with no offers" do
    subject { described_class.new }

    it "sums up prices correctly without any discount" do
      subject.add("R01")
      subject.add("R01")
      expect(subject.total).to eq(68.85)
    end
  end

  describe "with custom catalogue" do
    let(:custom_products) { [ { code: "X01", name: "Xtreme", price: 99.99 } ] }
    let(:custom_catalogue) { AcmeBasket::Catalogue::Base.new(custom_products) }
    subject { described_class.new(catalogue: custom_catalogue) }

    it "uses injected catalogue correctly" do
      subject.add("X01")
      # we expect delivery to be free (price > 90), because although we injected a
      # custom catalogue we still use the default delivery rules designed for widgets
      # We can inject custom delivery charge rules as well, but it is out of scope.
      expect(subject.total).to eq(99.99 + 0.0)
    end
  end
end
