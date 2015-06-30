require_relative "controllers/menu_controller"

menu = MenuController.new

# Clears the command line
system "clear"

puts "Welcome to AddressBloc!"
menu.main_menu