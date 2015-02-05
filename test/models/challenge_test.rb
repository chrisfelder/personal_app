require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  include ChallengesHelper
  
  test "should not save challenge without name, code, and description " do
    temp = Challenge.new
    assert_not temp.save, "Challenges do not validate"
  end
  
  test "should return bit position" do
    assert_equal "However, it was not implemented until 1998 and 2000", decode("2000 and was not However, implemented 1998 it until;9 8 3 4 1 5 7 2")
  end
  
  test "should return bit position 2 " do
    assert_equal "The first programming language", decode("programming first The language;3 2 1")
  end
  
  test" should return bit position 3 " do
    assert_equal "The Manchester Mark 1 ran programs written in Autocode from 1952", decode("programs Manchester The written ran Mark 1952 1 in Autocode from;6 2 1 7 5 3 11 4 8 9")
  end
end
