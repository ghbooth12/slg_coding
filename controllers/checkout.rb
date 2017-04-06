require_relative 'specials'

class Checkout
  def initialize
    @item_list = []
    @total = 0
    @sale = Specials.new
    @promo_counts = @sale.promo_counts
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

    final = (@total - @sale.apply(uniq_items, counts)).round(2)  # Used round for precision
    puts get_invoice + final.to_s
    final
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

  def get_invoice
    space = ' '*22
    rows = ["Item#{space}Price\n----#{space}----\n"]

    for item in @item_list
      rows << (item.code + space + item.price.to_s + "\n")
      promo = invoice_promo(item)
      rows << promo if promo
    end
    rows.join + "#{'-'*30}\n#{' '*25}"
  end

  def invoice_promo(item)
    space = ' '*10
    promos = @sale.promos
    promo = item.promo

    promos.each do |key,val|
      if key == item.code && @promo_counts[promo] > 0
        @promo_counts[promo] -= 1
        return space + promo + space + "-" + val.to_s + "\n"
      end
    end
    false
  end

end