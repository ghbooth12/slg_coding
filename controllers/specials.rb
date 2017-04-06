class Specials
  attr_reader :promos, :promo_counts

  def initialize
    @subtract = 0
    @promos = {}
    @promo_counts = {}
  end

  # This sums up discounted amount after applying applicable specials.
  # params) uniq_items: array (eg, [apples, chai])
  # params) counts: hash (eg, {"AP1" => 3, "CH1" => 1})
  def apply(uniq_items, counts)
    valid_pair = pair_validator(uniq_items)

    uniq_items.each do |item|
      num = counts[item.code]

      bogo(num, item) if item.promo == "BOGO"
      buy3(num, item) if item.promo == "BUY3"
      pair(item) if item.promo == "PAIR" && item.pair_gift && valid_pair
    end

    @subtract
  end

  private

  # item that is qualified for specials like CHMK
  def pair_validator(uniq_items)
    gift = false
    pair = false

    for item in uniq_items
      if item.promo == "PAIR"
        item.pair_gift ? gift = true : pair = true
      end
    end

    gift && pair
  end

  # This returns discounted amount for Buy-One-Get-One-Free Special (Unlimited).
  def bogo(num, item)
    return 0 if num < 2
    price = item.price
    amount = price * (num / 2)

    if amount > 0
      @subtract += amount
      @promos[item.code] = price
      @promo_counts["BOGO"] = num / 2
    end
  end

  # This returns discounted amount when buying more than 3 of the item.
  def buy3(num, item)
    return 0 if num < 3
    diff = item.price - item.sale_price
    amount = diff * num

    if amount > 0
      @subtract += amount
      @promos[item.code] = diff
      @promo_counts["BUY3"] = num
    end
  end

  # This returns discounted amount when buying item that is paired with other item.
  # eg) Purchase a box of Chai and get milk free. (Limit 1)
  def pair(item)
    price = item.price

    @subtract += price
    @promos[item.code] = price
    @promo_counts["PAIR"] = 1
  end

end