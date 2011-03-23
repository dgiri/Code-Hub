class Post < ActiveRecord::Base
  has_many :language_posts
  has_many :languages, :through => :language_posts
  has_many :comments, :as => :commentable
  belongs_to :user
  
  validates_presence_of :topic, :description, :code
  
  cattr_reader :per_page
  @@per_page = 5  
  
  acts_as_rateable :average => true
   
  scope :has_ratings, :joins => :ratings, :select => 'DISTINCT  posts.id, posts.topic, posts.created_at', :order =>'posts.topic'  
end
