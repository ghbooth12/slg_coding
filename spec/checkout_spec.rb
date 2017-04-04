require_relative '../checkout'

describe Checkout do
  let(:co) { Checkout.new }
  let(:coffee) { Items::CF1 }

  context "#scan" do
    it "should return correct amount" do
      co.scan(coffee)
      expect(co.get_total).to eq coffee[:price]
    end
  end
end