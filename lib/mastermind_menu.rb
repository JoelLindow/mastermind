require './lib/game'

class MastermindMenu

  def start_menu
    game = Game.new
    puts game.main_menu
    menu_input = gets.chomp.downcase
    handle_menu_input(game, menu_input)
  end

  def handle_menu_input(game, menu_input)
    if menu_input == ("q" || "quit")
      puts game.quit_game
    elsif menu_input == ("i" || "instructions")
      puts game.show_instructions
      start_menu
    elsif menu_input == ("p" || "play")
      system "clear"
      game.game_start_time = Time.now
      puts game.start_game_message
      game.active_game_play
    else
      system "clear"
      start_menu
    end
  end

end
