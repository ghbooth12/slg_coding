require_relative 'items'
require_relative 'checkout'

class MenuController
  def menu
    co = Checkout.new
    chai   = Items.new({code: "CH1", name: "Chai", price: 3.11, sale_price: nil, promo: "PAIR", pair_gift: false})
    apples = Items.new({code: "AP1", name: "Apples", price: 6.00, sale_price: 4.5, promo: "BUY3", pair_gift: false})
    coffee = Items.new({code: "CF1", name: "Coffee", price: 11.23, sale_price: nil, promo: "BOGO", pair_gift: false})
    milk   = Items.new({code: "MK1", name: "Milk", price: 4.75, sale_price: nil, promo: "PAIR", pair_gift: true})

    ask_input
    input = gets.chomp

    while input != "" && input != "exit"
      case input
      when "chai"
        co.scan(chai)
        ask_input
      when "apples"
        co.scan(apples)
        ask_input
      when "coffee"
        co.scan(coffee)
        ask_input
      when "milk"
        co.scan(milk)
        ask_input
      else
        puts "Please type correct product name."
        ask_input
      end
      input = gets.chomp
    end

    co.get_total if input == ""
    puts "\n\nGood-bye. We hope to see you again soon."
  end

  def ask_input
    print "\nPlease enter item name: "
  end

end