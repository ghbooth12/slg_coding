class Items
  attr_reader :code, :name, :price, :sale_price, :bogo, :three_and_more, :combo, :combo_free

  def initialize(data)
    @code           = data[:code]
    @name           = data[:name]
    @price          = data[:price]
    @sale_price     = data[:sale_price]
    @bogo           = data[:bogo]
    @three_and_more = data[:three_and_more]
    @combo          = data[:combo]
    @combo_free     = data[:combo_free]
  end
end

# variables
# code: string (eg, "CH1" for chai)
# name: string (eg, "chai")
# price: float (eg, 3.11)
# sale_price: float (eg, 2.99) or nil when item is not on sale.
# bogo: boolean (if item is qualified for Buy-One-Get-One-Free specials, then true or false)
# three_and_more: boolean (if item is qualified for dropping price when buying more than three, then true or false)
# combo: boolean (if item is paired with other item, then true or false. eg, buy chai, get milk free)
# combo_free: boolean (if item is a free gift when paired item is purchased, then true of false)