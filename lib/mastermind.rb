class Mastermind

  def main_menu
    "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def run(command)
    commands[command]
  end

  def commands
    # { "i" => Instructions.print }
    { "i" => "These are the instructions" }
  end
end

mastermind = Mastermind.new
puts mastermind.main_menu
input = gets.chomp
puts mastermind.run(input)


#write test for run method, while putting in "i" to verify where it takes you
#write test for quit
#prite test for play

#While loop (think about it) 
