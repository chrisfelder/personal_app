require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  def setup
    @character = Character.create(name: "Bob Dylan" ,  strength: 10,
      defense: 10, hp_current: 100, hp_max: 100, user_id: 1, miner: 0,
      lumberjack: 0, hunter: 0, builder: 0, farmer: 0)
  end
  
  test "should be valid" do
    assert @character.valid?
  end
  
  test "name should be present" do
    @character.name = ""
    assert_not @character.valid?
  end
  
  test "strength should be present" do
    @character.strength = ""
    assert_not @character.valid?
  end
  
  test "strength should be > 0" do
    @character.strength = 0
    assert_not @character.valid?
  end
  
  test "hp_current should be < hp_max" do
    @character.hp_current = 150
    assert_not @character.valid?
  end
  
  test "hp_max should be > 0" do
    @character.hp_max = 0
    assert_not @character.valid?
  end
end
