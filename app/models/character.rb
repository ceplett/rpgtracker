require 'rexml/document'

class Character < ActiveRecord::Base
  ABILITIES = [:strength, :constitution, :dexterity, :intelligence, :wisdom, :charisma]

  has_attached_file :sheet

  after_sheet_post_process :store_sheet_for_import
  before_validation :import_sheet

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
    return if @doc.blank?
    details    = @doc.root.elements['CharacterSheet/Details']
    self.name  = details.elements['name'].text.strip
    self.level = details.elements['Level'].text.strip.to_i

    stats      = @doc.root.elements['CharacterSheet/StatBlock']
    ABILITIES.each do |ability|
      elt = stats.elements["Stat/alias[@name='#{ability.to_s.titlecase}']"]
      self.send("#{ability}=".to_sym, elt && elt.parent.attributes['value'].to_i)

      elt = stats.elements["Stat/alias[@name='#{ability.to_s.titlecase} modifier']"]
      self.send("#{ability}_modifier=".to_sym, elt && elt.parent.attributes['value'].to_i)
    end

    rules      = @doc.root.elements['CharacterSheet/RulesElementTally']
    self.race  = rules.elements["RulesElement[@type='Race']"].attributes['name']
    self.klass = rules.elements["RulesElement[@type='Class']"].attributes['name']
    self.build = rules.elements["RulesElement[@type='Build']"].attributes['name']
  end

  def store_sheet_for_import
    file = sheet.queued_for_write[:original]
    @doc = REXML::Document.new file
  end

end
