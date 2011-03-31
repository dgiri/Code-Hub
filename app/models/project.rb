class Project < ActiveRecord::Base
  has_many :project_users, :dependent => :destroy
  has_many :users, :through => :project_users
  has_many :stories, :dependent => :destroy
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :details, :message => "can't be blank"  
end
