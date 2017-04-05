require_relative 'items'
require_relative 'specials'
require 'pry'

class Checkout
  include Specials

  def initialize
    @item_list = []
    @total = 0
  end

  # Everytime item is scanned, the item is pushed to @item_list and @total is increased.
  # params) item: Items object
  def scan(item)
    @item_list << item
    @total += item.price
  end

  # This returns the total amount after subtracting discounted amount.
  def get_total
    counts = convert_to_hash(@item_list)
    uniq_items = @item_list.uniq

    (@total - apply(uniq_items, counts)).round(2)  # Used round for precision
  end

  private

  # This counts the items and creates a hash with item name as a key and count as a value.
  # eg) {"CH1" => 1, "AP1" => 3}
  # params) item_list: array
  def convert_to_hash(item_list)
    counts = Hash.new(0)
    item_list.each { |item| counts[item.code] += 1 }
    counts
  end
end