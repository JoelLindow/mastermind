require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def test_it_exists
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

  def test_it_can_detect_cheat_requested
    game = Game.new
    assert game.cheat_requested?("C")
    assert game.cheat_requested?("CHEAT")
    refute game.cheat_requested?("BANANA")
  end

  def test_it_can_check_if_guess_is_wrong_length
    game = Game.new
    refute game.wrong_length?("RRRR")
    assert game.wrong_length?("RRR")
    assert game.wrong_length?("RRRBB")
  end

  def test_it_can_set_attributes_from_recorded_guess
    game = Game.new(["R", "R", "R", "R"])
    game.record_guess("GRBY")
    assert_equal ["G", "R", "B", "Y"], game.current_guess
    assert_equal ["X", "R", "X", "X"], game.guess_checked_for_wrongs
    assert_equal 1, game.correct_positions
    assert_equal 1, game.correct_colors
  end




end
