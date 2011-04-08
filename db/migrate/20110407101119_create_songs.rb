class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :name
      t.string :mp3_file_name
      t.string :mp3_content_type
      t.integer :mp3_file_size
      t.datetime :mp3_updated_at
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :songs
  end
end