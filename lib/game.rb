require './lib/messages'
require './lib/guess_evaluator'
# require './lib/mastermind'
require 'pry'

class Game
  attr_reader :random_combo, :message, :guess_evaluator
  attr_accessor :current_guess, :guess_checked_for_wrongs, :correct_positions,
  :correct_colors, :guess_counter, :game_start_time, :game_end_time

  def initialize(random_combo = generate_random_combo)
    @random_combo = random_combo
    @message = Messages.new
    @guess_evaluator = GuessEvaluator.new
    @current_guess = []
    @guess_checked_for_wrongs = []
    @correct_positions = 0
    @correct_colors = 0
    @guess_counter = 0
    @game_start_time = 0
    @game_end_time = 0

  end

  def generate_random_combo
    pegs = ["R", "G", "B", "Y"]
    pegs.map do   #<--- iterates through once for each peg in array.
      pegs.shuffle.pop  #<--- shuffles the array before popping each time map iterates
    end
  end

  def active_game_play
    user_input = gets.chomp.upcase
  unless cheat_requested?(user_input) || wrong_length?(user_input) || quit_requested?(user_input)
      record_guess(user_input)
      @guess_checked_for_wrongs = guess_evaluator.compare_random_to_guess
      @correct_positions = count_correct_peg_positions
      @correct_colors = count_correct_peg_colors
    end
    critique_guess(user_input)

  end


  def critique_guess(user_input)
    if current_guess == random_combo
      @guess_counter += 1
      system "clear"
      @game_end_time = Time.now
      puts message.correct_guess(current_guess, guess_counter, game_length_timer[0], game_length_timer[1])
      reset_all_parameters
      keep_playing = gets.chomp
      if keep_playing == ("p" || "play")
        mastermind = Mastermind.new
        mastermind.start_menu
      elsif keep_playing == ("q" || "quit")
        quit_game
      end
    elsif cheat_requested?(user_input)
      system "clear"
      puts message.cheat(random_combo)
      sleep(2)
      system "clear"
      puts message.wrong_guess(current_guess, correct_colors, correct_positions, guess_counter)
      active_game_play
    elsif quit_requested?(user_input)
      system "clear"
      puts message.goodbye
    elsif wrong_length?(user_input)
      if user_input.length > 4
        puts message.too_long
      else
        puts message.too_short
      end
      active_game_play
    else
      @guess_counter += 1
      system "clear"
      puts message.wrong_guess(current_guess, correct_colors, correct_positions, guess_counter)
      active_game_play
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

  def record_guess(user_input)
    @current_guess = user_input.chars
    guess_evaluator.current_guess = current_guess
    guess_evaluator.random_sequence = random_combo
  end

  def game_length_timer
    game_timer = (game_end_time - game_start_time).to_i
    minutes = (game_timer / 60)
    seconds = (game_timer % 60)
    [minutes, seconds]
  end

  def reset_all_parameters
    @random_combo = generate_random_combo
    @current_guess = nil
    @guess_checked_for_wrongs = nil
    @correct_positions = nil
    @correct_colors = nil
    @guess_counter = 0
    @game_start_time = nil
    @game_end_time = nil
  end

  def cheat_requested?(user_input)
    ["C", "CHEAT"].include?(user_input)
  end

  def quit_requested?(user_input)
    ["Q", "QUIT"].include?(user_input)
  end

  def wrong_length?(user_input)
    user_input.length > 4 || user_input.length < 4
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
