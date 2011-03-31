class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "30x30>", :thin => "70x90" }
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # devise :database_authenticatable, :registerable, :confirmable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :sort_name  
  
  # validates_attachment_presence :avatar
  # validates_attachment_size :avatar, :less_than => 5.megabytes  
  # validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png'] 
  
  has_many :posts
  has_many :comments
  has_many :project_users
  has_many :projects, :through => :project_users
  has_many :stories
  has_many :tasks  
  
  def full_name
    @full_name ||= "#{first_name} #{last_name}"
  end  
end
