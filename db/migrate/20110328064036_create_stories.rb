class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :project_id
      t.string :title
      t.text :description
      t.string :story_type
      t.integer :points
      t.string :label
      t.integer :owner
      t.integer :requester
      
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
