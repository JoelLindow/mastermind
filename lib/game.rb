require './lib/message'
require './lib/guess_evaluator'

class Game
  attr_reader :random_combo, :message, :guess_evaluator
  attr_accessor :current_guess, :guess_checked_for_wrongs, :correct_positions,
  :correct_colors, :guess_counter, :game_start_time, :game_end_time

  def initialize(random_combo = generate_random_combo)
    @random_combo = random_combo
    @message = Message.new
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
    pegs.map do
      pegs.shuffle.pop
    end
  end

  def active_game_play
    user_input = gets.chomp.upcase
    unless not_a_valid_guess?(user_input)
      record_guess(user_input)
    end
    critique_guess(user_input)
  end


  def critique_guess(user_input)
    if current_guess == random_combo
      win_game_flow
    elsif cheat_requested?(user_input)
      cheat_requested_flow
    elsif quit_requested?(user_input)
      system "clear"
      puts message.goodbye
    elsif wrong_length?(user_input)
      wrong_length_flow(user_input)
    else
      wrong_answer_flow
    end
  end

  def wrong_answer_flow
    @guess_counter += 1
    system "clear"
    puts wrong_guess
    active_game_play
  end

  def wrong_length_flow(user_input)
    if user_input.length > 4
      puts message.too_long
    else
      puts message.too_short
    end
    active_game_play
  end

  def cheat_requested_flow
    system "clear"
    puts message.cheat(random_combo)
    sleep(2)
    system "clear"
    puts wrong_guess
    active_game_play
  end

  def win_game_flow
    @guess_counter += 1
    system "clear"
    @game_end_time = Time.now
    puts correct_guess
    reset_all_parameters
    keep_playing = gets.chomp
    restart_or_quit(keep_playing)
  end

  def restart_or_quit(keep_playing)
    if keep_playing == ("p" || "play")
      mastermind = MastermindMenu.new
      mastermind.start_menu
    elsif keep_playing == ("q" || "quit")
      quit_game
    end
  end

  def record_guess(user_input)
    @current_guess = user_input.chars
    guess_evaluator.current_guess = current_guess
    guess_evaluator.random_sequence = random_combo
    @guess_checked_for_wrongs = guess_evaluator.compare_random_to_guess
    @correct_positions = guess_evaluator.count_correct_peg_positions
    @correct_colors = guess_evaluator.count_correct_peg_colors
  end

  def game_length_timer
    game_timer = (game_end_time - game_start_time).to_i
    minutes = (game_timer / 60)
    seconds = (game_timer % 60)
    [minutes, seconds]
  end

  def reset_all_parameters
    @random_combo = generate_random_combo
    @current_guess = []
    @guess_checked_for_wrongs = []
    @correct_positions = []
    @correct_colors = 0
    @guess_counter = 0
    @game_start_time = 0
    @game_end_time = 0
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

  def not_a_valid_guess?(user_input)
    cheat_requested?(user_input) || wrong_length?(user_input) || quit_requested?(user_input)
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

  def wrong_guess
    message.wrong_guess(current_guess,
                        correct_colors,
                        correct_positions,
                        guess_counter)
  end

  def correct_guess
    message.correct_guess(current_guess,
                          guess_counter,
                          game_length_timer[0],
                          game_length_timer[1])
  end
end
