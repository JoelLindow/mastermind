class Game

  def main_menu
    "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def quit_game
    "Goodbye"
  end

  def run(menu_input)
    commands[menu_input]
  end

  def commands
    # { "i" => Instructions.print }
    { "i" => "These are the instructions",
      "p" => "This is the game",
      "q" => "This is how you quit"}
  end
end

#DREAM DRIVEN DEVELOPMENT GOES HERE
# mastermind = Game.new
# puts mastermind.main_menu
# input = gets.chomp
# puts mastermind.run(input)


#write test for run method, while putting in "i" to verify where it takes you
#write test for quit
#prite test for play

#While loop (think about it)
