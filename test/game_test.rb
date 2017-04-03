require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require 'pry'


class GameTest < Minitest::Test

  def test_is_exists
    game = Game.new
    assert_equal Game, game.class
  end

  def test_main_menu
    game = Game.new
    greeting = "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
    assert_equal greeting, game.main_menu
  end

  def test_it_says_goodbye_when_you_quit
    game = Game.new
    goodbye = "Goodbye"
    assert_equal goodbye, game.quit_game
  end

  def test_it_shows_instructions
    game = Game.new
    instructions = "HOW TO PLAY MASTERMIND"
    assert_includes game.show_instructions, instructions
  end

  def test_it_can_show_start_game_message
    game = Game.new
    start = "I have generated a beginner sequence"
    assert_includes game.start_game_message, start
  end

  def test_it_can_compare_random_to_guess_for_wrongs
    game = Game.new(["R", "R", "R", "R"])
    game.current_guess = ["R", "R", "R", "Y"]
    checked_for_wrongs = ["R", "R", "R", "WRONG"]
    assert_equal checked_for_wrongs, game.compare_random_to_guess
  end

  def test_it_can_count_correct_peg_positions
  end

  def test_it_can_count_correct_peg_colors
  end

end #<-- class end
