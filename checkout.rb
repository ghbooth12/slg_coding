require_relative 'items'
require_relative 'specials'
require 'pry'

class Checkout
  include Specials

  def initialize
    @item_list = []
    @total = 0
  end

  def scan(item)
    @item_list << item
    @total += item[:price]
  end

  def get_total
    (@total - apply(@item_list)).round(2)
  end
end