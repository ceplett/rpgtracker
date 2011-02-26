require 'rexml/document'

class Character < ActiveRecord::Base
  ABILITIES = [:strength, :constitution, :dexterity, :intelligence, :wisdom, :charisma]
  DEFENSES  = [:armor_class, :fortitude, :reflex, :will]

  has_attached_file :sheet

  after_sheet_post_process :import_sheet

  validates :name, :presence => true

  def description
    "Level #{level} #{race} #{build}"
  end

  def half_level
    (self.level / 2.0).floor
  end

  def ability_mod(ability)
    self.send("#{ability}_modifier".to_sym)
  end

  def ability_chk(ability)
    self.ability_mod(ability) + half_level
  end

private

  def import_sheet
    parser = Nokogiri::XML::SAX::Parser.new(Character::Sheet.new(self))
    parser.parse sheet.queued_for_write[:original]
  end

end
