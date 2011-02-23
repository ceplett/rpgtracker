class CreatePowers < ActiveRecord::Migration
  def self.up
    create_table :powers do |t|
      t.references  :character,     :null => false
      t.string      :name,          :null => false
      t.integer     :level,         :null => false
      t.string      :usage,         :null => false
      t.string      :action_type,   :null => false
      t.string      :compendium_url

      t.timestamps
    end
  end

  def self.down
    drop_table :powers
  end
end
