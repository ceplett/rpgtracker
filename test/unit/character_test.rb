require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

  test 'importing a character sheet' do
    char = Character.new :sheet => File.new(fixture_file('Immilzin.dnd4e'))
    assert char.valid?
    assert_equal 'Immilzin', char.name
    assert_equal 1, char.level
    assert_equal 'Avenger', char.klass
    assert_equal 'Pursuing Avenger', char.build
    assert_equal 8, char.strength
    assert_equal -1, char.strength_modifier
    assert_equal 10, char.constitution
    assert_equal 0, char.constitution_modifier
    assert_equal 15, char.dexterity
    assert_equal 2, char.dexterity_modifier
    assert_equal 13, char.intelligence
    assert_equal 1, char.intelligence_modifier
    assert_equal 20, char.wisdom
    assert_equal 5, char.wisdom_modifier
    assert_equal 10, char.charisma
    assert_equal 0, char.charisma_modifier
  end

  test 'description' do
    char = Character.new :sheet => File.new(fixture_file('Bronwyn.dnd4e'))
    assert char.valid?
    assert_equal 'Level 17 Elf Devoted Cleric', char.description
    char = Character.new :sheet => File.new(fixture_file('Immilzin.dnd4e'))
    assert char.valid?
    assert_equal 'Level 1 Githzerai Pursuing Avenger', char.description
  end

  test 'half level' do
    char = Character.new :sheet => File.new(fixture_file('Bronwyn.dnd4e'))
    assert char.valid?
    assert_equal 8, char.half_level
    char = Character.new :sheet => File.new(fixture_file('Immilzin.dnd4e'))
    assert char.valid?
    assert_equal 0, char.half_level
  end

end
