require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/mastermind.rb'
require 'pry'


class MastermindTest < Minitest::Test

  def test_is_exists
    mastermind = Mastermind.new
    assert_equal Mastermind, mastermind.class
  end

  def test_main_menu
    mastermind = Mastermind.new
    greeting = "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
    assert_equal greeting, mastermind.main_menu
  end

  def test_if_can_input
    mastermind = Mastermind.new

  end


end #<-- class end
