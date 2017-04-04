require './lib/game'

class Mastermind

  def start_menu
    game = Game.new
    puts game.main_menu
    menu_input = gets.chomp.downcase
    handle_menu_input(game, menu_input)  #<--- passing info
  end

  def handle_menu_input(game, menu_input)  #<--- taking in info
    if menu_input == ("q" || "quit")
      puts game.quit_game
    elsif menu_input == ("i" || "instructions")
      puts game.show_instructions
      start_menu
    elsif menu_input == ("p" || "play")
      system "clear"
      puts game.start_game_message
      game.start_game
    end
  end

end  #<--class Mastermind End

mastermind = Mastermind.new  #<-- new instance
mastermind.start_menu        #<-- new instance starting at start menu_input
