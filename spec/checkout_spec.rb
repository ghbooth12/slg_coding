require_relative '../checkout'

describe Checkout do
  let(:co) { Checkout.new }
  let(:chai) { Items.new({code: "CH1", name: "Chai", price: 3.11, sale_price: nil, bogo: false, three_and_more: false, combo: true, combo_free: false}) }
  let(:apples) { Items.new({code: "AP1", name: "Apples", price: 6.00, sale_price: 4.5, bogo: false, three_and_more: true, combo: false, combo_free: false}) }
  let(:coffee) { Items.new({code: "CF1", name: "Coffee", price: 11.23, sale_price: nil, bogo: true, three_and_more: false, combo: false, combo_free: false}) }
  let(:milk) { Items.new({code: "MK1", name: "Milk", price: 4.75, sale_price: nil, bogo: false, three_and_more: false, combo: true, combo_free: true}) }

  context "#scan" do
    it "should return correct amount" do
      co.scan(coffee)
      expect(co.get_total).to eq coffee.price
    end
  end

  context "#get_total" do
    it "should return correct amount when basket has chai, apples, coffee and milk" do
      co.scan(chai)
      co.scan(apples)
      co.scan(coffee)
      co.scan(milk)
      total = 20.34
      expect(co.get_total).to eq total
    end

    it "should return correct amount when basket has milk and apples" do
      co.scan(milk)
      co.scan(apples)
      total = 10.75
      expect(co.get_total).to eq total
    end

    it "should return correct amount when basket has two bags of coffee" do
      co.scan(coffee)
      co.scan(coffee)
      total = 11.23
      expect(co.get_total).to eq total
    end

    it "should return correct amount when basket has three bags of apples and chai" do
      co.scan(apples)
      co.scan(apples)
      co.scan(chai)
      co.scan(apples)
      total = 16.61
      expect(co.get_total).to eq total
    end
  end

end