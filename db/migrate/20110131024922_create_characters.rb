class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.references  :player
      t.references  :campaign
      t.string      :name

      t.string    :token_file_name
      t.string    :token_content_type
      t.integer   :token_file_size
      t.datetime  :token_updated_at

      t.string    :portrait_file_name
      t.string    :portrait_content_type
      t.integer   :portrait_file_size
      t.datetime  :portrait_updated_at

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
