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

  def test_respond_to_current_guess
    game = Game.new
    assert game.respond_to?(:generate_random_combo)
  end

  def test_it_says_goodbye_when_you_quit
    game = Game.new
    goodbye = "Goodbye"
    assert_equal goodbye, game.quit_game
  end

  def test_it_shows_instructions
    game = Game.new
    instructions = "Mastermind is a game where you must try"
    assert_includes game.show_instructions, instructions
  end

  def test_it_can_show_start_game_message
    game = Game.new
    start = "I have generated a beginner sequence"
    assert_includes game.start_game_message, start
  end


  def test_it_can_count_correct_peg_colors
    game = Game.new(["R", "Y", "R", "B"])
    game.current_guess = ["B", "R", "R", "G"]
    assert_equal 3, game.count_correct_peg_colors
    # binding.pry
  end

  def test_it_can_count_correct_peg_positions
    game = Game.new(["R", "Y", "R", "B"])
    game.current_guess = ["B", "R", "R", "G"]
    game.guess_checked_for_wrongs = game.compare_random_to_guess
    assert_equal 1, game.count_correct_peg_positions
  end

end #<-- class end
