require 'minitest/autorun'
require 'minitest/pride'
require './lib/guess_evaluator'

class GuessEvaluatorTest < Minitest::Test

  def test_it_exists
    guess = GuessEvaluator.new
    assert_instance_of GuessEvaluator, guess
  end


  def test_it_can_compare_random_sequence_to_user_guess_for_wrongs
    guess_evaluator = GuessEvaluator.new
    guess_evaluator.current_guess = ["R", "R", "R", "Y"]
    guess_evaluator.random_sequence = ["R", "R", "R", "R"]
    checked_for_wrongs = ["R", "R", "R", "X"]

    assert_equal checked_for_wrongs, guess_evaluator.compare_random_to_guess
  end

  def test_it_can_count_correct_peg_colors
    guess_evaluator = GuessEvaluator.new
    guess_evaluator.current_guess = ["R", "R", "R", "Y"]
    guess_evaluator.random_sequence = ["R", "R", "R", "R"]

    assert_equal 3, guess_evaluator.count_correct_peg_colors
  end

  def test_it_can_count_correct_peg_positions
    guess_evaluator = GuessEvaluator.new
    guess_evaluator.current_guess = ["R", "G", "B", "R"]
    guess_evaluator.random_sequence = ["R", "R", "R", "R"]

    assert_equal 2, guess_evaluator.count_correct_peg_positions
  end
end
