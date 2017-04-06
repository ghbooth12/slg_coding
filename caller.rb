require_relative "controllers/menu_controller"

system "clear"
puts "#{'-'*30}\nWelcome to Farmer's Market.\n#{'-'*30}"
puts "\nProducts: chai, apples, coffee, milk"
puts "\nIf you want to check out, please hit enter(return)."
puts "If you want to exit, please type 'exit'."

main = MenuController.new
main.menu