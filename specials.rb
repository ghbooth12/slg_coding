require_relative 'items'

module Specials
  def apply(item_list)
    subtract = 0
    subtract += bogo(item_list)

    subtract
  end

  def bogo(item_list)
    coffee = Items::CF1
    return if item_list.empty? || !item_list.include?(coffee)

    item_list_cp = item_list
    coffee_count = 0
    include_coffee = true

    while include_coffee != nil
      include_coffee = item_list_cp.delete(coffee)
      coffee_count += 1 if include_coffee
    end

    coffee[:price] * (coffee_count.even? ? coffee_count : coffee_count-1)
  end

end