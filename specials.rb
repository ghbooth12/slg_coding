require_relative 'items'

module Specials
  # This sums up discounted amount after applying applicable specials.
  # params) uniq_items: array (eg, [apples, chai])
  # params) counts: hash (eg, {"AP1" => 3, "CH1" => 1})
  def apply(uniq_items, counts)
    subtract = 0
    combo_item = nil

    uniq_items.each do |item|
      if item.combo && !item.combo_free
        combo_item = item  # item that is qualified for specials like CHMK
      end

      num = counts[item.code]

      subtract += bogo(num, item) if item.bogo
      subtract += three_and_more(num, item) if item.three_and_more
      subtract += combo(num, item) if item.combo && item.combo_free && combo_item
    end

    subtract
  end

  # This returns discounted amount for Buy-One-Get-One-Free Special (Unlimited).
  def bogo(num, item)
    return 0 if num < 2
    item.price * (num / 2)
  end

  # This returns discounted amount when buying more than 3 of the item.
  def three_and_more(num, item)
    return 0 if num < 3
    (item.price - item.sale_price) * num
  end

  # This returns discounted amount when buying item that is paired with other item.
  # eg) Purchase a box of Chai and get milk free. (Limit 1)
  def combo(num, item)
    item.price
  end

end