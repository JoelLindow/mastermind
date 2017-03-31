require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game.rb'
require 'pry'


class GameTest < Minitest::Test

  def test_is_exists
    mastermind = Game.new
    assert_equal Game, mastermind.class
  end

  def test_main_menu
    mastermind = Game.new
    greeting = "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
    assert_equal greeting, mastermind.main_menu
  end

  def test_if_can_input
    mastermind = Game.new
    arguement = mastermind.run("i")
    assert_equal arguement, "These are the instructions"
  end


end #<-- class end
