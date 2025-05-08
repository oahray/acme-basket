RSpec.describe AcmeBasket::DeliveryRule::WidgetCharge do
  subject { described_class.new }

  it "charges $4.95 for orders under $50" do
    expect(subject.call(49.99)).to eq(4.95)
  end

  it "charges $2.95 for orders between $50 and $89.99" do
    expect(subject.call(50)).to eq(2.95)
    expect(subject.call(89.99)).to eq(2.95)
  end

  it "charges $0 for orders $90 and above" do
    expect(subject.call(90)).to eq(0)
    expect(subject.call(150)).to eq(0)
  end
end
