class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.references  :gm,          :null => false
      t.string      :title,       :null => false
      t.text        :description
      t.timestamps
    end

    add_index :campaigns, :gm_id
  end

  def self.down
    drop_table :campaigns
  end
end
