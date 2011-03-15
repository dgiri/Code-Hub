class CreateLanguagePosts < ActiveRecord::Migration
  def self.up
    create_table :language_posts do |t|
      t.integer :language_id
      t.integer :post_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :language_posts
  end
end
