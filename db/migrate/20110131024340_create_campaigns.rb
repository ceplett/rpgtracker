class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.references :gm
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
