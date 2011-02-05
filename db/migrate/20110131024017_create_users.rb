class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name,  :null => false
      t.string  :email, :null => false
      t.timestamps
    end

    add_index :users, :name, :unique => true
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :name
    drop_table :users
  end
end