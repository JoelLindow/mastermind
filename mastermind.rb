require './lib/game.rb'

game = Game.new
puts game.main_menu
menu_input = gets.chomp.downcase

if menu_input == "q"
  puts game.quit_game
end
