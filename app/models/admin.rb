class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # devise :database_authenticatable, :registerable, :confirmable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :trackable, :timeoutable, :lockable, :registerable, :timeout_in => 20.minutes       
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation
end



