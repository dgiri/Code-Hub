class Language < ActiveRecord::Base
  has_many :language_posts
  has_many :posts, :through => :language_posts
  validates_presence_of :name, :description, :alias  
end
