require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/message'
require 'pry'

class MessageTest < Minitest::Test

  def test_it_exists
    message = Message.new
    assert_instance_of Message, message
  end

end
