class Items
  attr_reader :code, :name, :price, :sale_price, :promo, :pair_gift

  def initialize(data)
    @code           = data[:code]
    @name           = data[:name]
    @price          = data[:price]
    @sale_price     = data[:sale_price]
    @promo          = data[:promo]
    @pair_gift      = data[:pair_gift]
  end
end

# variables
# code: string (eg, "CH1" for chai)
# name: string (eg, "chai")
# price: float (eg, 3.11)
# sale_price: float (eg, 2.99) or nil when item is not on sale.
# promo: string (eg. "BOGO", "BUY3", "PAIR")
# pair_gift: boolean (if item is a free gift when paired item is purchased, then true of false)