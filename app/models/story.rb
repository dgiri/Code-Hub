class Story < ActiveRecord::Base
  STORY_TYPES = ['Feature', 'Bug', 'Chore']
  STORY_LEVELS = ['Design', 'On hold', 'Important', 'High Priority', 'Low Priority']
  STORY_POINTS = [0, 1, 2, 3, 5, 8]
  
  validates_presence_of :title
  
  belongs_to :project
  belongs_to :story_owner, :class_name => "User", :foreign_key => "owner"
  belongs_to :story_requester, :class_name => "User", :foreign_key => "requester"
  
  has_many :tasks
  has_many :comments, :as => :commentable
  
  cattr_reader :per_page
  @@per_page = 2
    
  named_scope :features, :conditions => {:story_type => "Feature"}
  named_scope :bugs, :conditions => {:story_type => "Bug"}
  named_scope :chores, :conditions => {:story_type => "Chore"}  
end
