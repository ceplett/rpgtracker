class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string    :name

      t.integer   :level
      t.string    :race
      t.string    :klass
      t.string    :build

      t.integer   :strength
      t.integer   :constitution
      t.integer   :dexterity
      t.integer   :intelligence
      t.integer   :wisdom
      t.integer   :charisma

      t.integer   :strength_modifier
      t.integer   :constitution_modifier
      t.integer   :dexterity_modifier
      t.integer   :intelligence_modifier
      t.integer   :wisdom_modifier
      t.integer   :charisma_modifier

      t.integer   :armor_class
      t.integer   :fortitude
      t.integer   :reflex
      t.integer   :will

      t.string    :sheet_file_name
      t.string    :sheet_content_type
      t.integer   :sheet_file_size
      t.datetime  :sheet_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
