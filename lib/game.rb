require './lib/messages'
require 'pry'

class Game
  attr_reader :random_combo, :message
  attr_accessor :current_guess, :guess_checked_for_wrongs, :correct_positions, :correct_colors

  def initialize(random_combo = generate_random_combo)
    @random_combo = random_combo
    @message = Messages.new
    @current_guess = nil
    @guess_checked_for_wrongs = nil
    @correct_positions = nil
    @correct_colors = nil
  end

  def generate_random_combo
    pegs = ["R", "G", "B", "Y"]
    pegs.map do   #<--- iterates through once for each peg in array.
      pegs.shuffle.pop  #<--- shuffles the array before popping each time map iterates
    end
  end

  def start_game
    take_a_guess
    @guess_checked_for_wrongs = compare_random_to_guess
    @correct_positions = count_correct_peg_positions
    @correct_colors = count_correct_peg_colors
  end

  def count_correct_peg_positions
    4 - @guess_checked_for_wrongs.count("WRONG")
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
  end

  def compare_random_to_guess
    random_combo.each_with_index.map do |letter, i|
      if letter == current_guess[i]
        letter
      else
        "WRONG"
      end
    end
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
