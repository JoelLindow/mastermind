require './lib/messages'
require './lib/guess_evaluator'
require 'pry'

class Game
  attr_reader :random_combo, :message, :guess_evaluator
  attr_accessor :current_guess, :guess_checked_for_wrongs, :correct_positions,
                :correct_colors, :guess_counter

  def initialize(random_combo = generate_random_combo)
    @random_combo = random_combo
    @message = Messages.new
    @guess_evaluator = GuessEvaluator.new
    @current_guess = nil
    @guess_checked_for_wrongs = nil
    @correct_positions = nil
    @correct_colors = nil
    @guess_counter = 0
  end

  def generate_random_combo
    pegs = ["R", "G", "B", "Y"]
    pegs.map do   #<--- iterates through once for each peg in array.
      pegs.shuffle.pop  #<--- shuffles the array before popping each time map iterates
    end
  end

  def start_game
    take_a_guess
    @guess_checked_for_wrongs = guess_evaluator.compare_random_to_guess
    @correct_positions = count_correct_peg_positions
    @correct_colors = count_correct_peg_colors
    # binding.pry
    critique_guess

  end

  def critique_guess
    @guess_counter += 1
    if current_guess == random_combo
      system "clear"
      puts message.correct_guess(current_guess)
    else
      system "clear"
      puts message.wrong_guess(current_guess, correct_colors, correct_positions, guess_counter)
      keep_playing = gets.chomp
      if keep_playing == "p"
        puts message.what_next_guess
        start_game
      elsif keep_playing == "q"
        quit_game
      else
        puts message.not_option_message
        critique_guess
      end
    end
  end


  def count_correct_peg_positions
    4 - @guess_checked_for_wrongs.count("X")
  end

  def count_correct_peg_colors
    color_check = random_combo.dup
    current_guess.each do |letter|
      if color_check.include?(letter)
        index = color_check.find_index(letter) #<---- this finds the first index where that letter occurs
        color_check.delete_at(index) #<----- only deletes the element at the index provided in the argumet
      end
    end
    4 - color_check.count
  end

  def take_a_guess
      @current_guess = gets.chomp.upcase.chars
      guess_evaluator.current_guess = current_guess
      guess_evaluator.random_sequence = random_combo
  end



  def show_instructions
    message.instructions
  end

  def start_game_message
    message.start_game_prompt
  end

  def quit_game
    message.goodbye
  end

  def main_menu
    message.main_menu
  end
end
