require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/mastermind_menu'

class MastermindMenuTest < Minitest::Test

  def test_it_exists
    menu = MastermindMenu.new
    assert_instance_of MastermindMenu, menu
  end

end
