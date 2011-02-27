class CreatePowers < ActiveRecord::Migration
  def self.up
    create_table :powers do |t|
      t.references  :character
      t.string      :name
      t.string      :power_usage
      t.string      :action_type
      t.string      :compendium_url

      t.timestamps
    end

    add_index :powers, :character_id
    add_index :powers, :name
  end

  def self.down
    drop_table :powers
  end
end