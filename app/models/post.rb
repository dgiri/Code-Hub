class Post < ActiveRecord::Base
  has_many :language_posts
  has_many :languages, :through => :language_posts
  belongs_to :user
  
  validates_presence_of :topic, :description, :code
  
  cattr_reader :per_page
  @@per_page = 5  
end
