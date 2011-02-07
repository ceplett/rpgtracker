class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.references  :campaign,  :null => false
      t.string      :email,     :null => false
      t.references  :player

      t.timestamps
    end

    add_index :invitations, :campaign_id
    add_index :invitations, :email
    add_index :invitations, :player_id
  end

  def self.down
    drop_table :invitations
  end
end