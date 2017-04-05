require_relative '../checkout'
require_relative '../specials'

describe Specials do
  let(:co) { Checkout.new }
  let(:chai) { Items.new({code: "CH1", name: "Chai", price: 3.11, sale_price: nil, bogo: false, three_and_more: false, combo: true, combo_free: false}) }
  let(:apples) { Items.new({code: "AP1", name: "Apples", price: 6.00, sale_price: 4.5, bogo: false, three_and_more: true, combo: false, combo_free: false}) }
  let(:coffee) { Items.new({code: "CF1", name: "Coffee", price: 11.23, sale_price: nil, bogo: true, three_and_more: false, combo: false, combo_free: false}) }
  let(:milk) { Items.new({code: "MK1", name: "Milk", price: 4.75, sale_price: nil, bogo: false, three_and_more: false, combo: true, combo_free: true}) }

  context "#apply" do
    it "should return 0.0 when it is not qualified for any specials" do
      uniq_items = [milk, apples]
      counts = {"MK1" => 1, "AP1" => 1}
      expect(co.apply(uniq_items, counts)).to eq 0.0
    end

    it "should return correct discount amount in case of BOGO" do
      uniq_items = [coffee]
      counts = {"CF1" => 2}
      expect(co.apply(uniq_items, counts)).to eq coffee.price
    end

    it "should return correct discount amount in case of APPL" do
      uniq_items = [apples, chai]
      counts = {"AP1" => 3, "CH1" => 1}
      discount = (apples.price - apples.sale_price) * 3
      expect(co.apply(uniq_items, counts)).to eq discount
    end

    it "should return correct discount amount in case of CHMK" do
      uniq_items = [chai, apples, coffee, milk]
      counts = {"CH1" => 1, "AP1" => 1, "CF1" => 1, "MK1" => 1}
      expect(co.apply(uniq_items, counts)).to eq milk.price
    end
  end

end