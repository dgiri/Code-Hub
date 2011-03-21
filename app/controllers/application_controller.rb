class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # before_filter :mailer_set_url_options
  # def mailer_set_url_options
  #   ActionMailer::Base.default_url_options[:host] = request.host_with_port
  # end

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  before_filter :all_users_list
  
  protected
  def authenticate_user!
    unauthorized_user if (!user_signed_in?)
  end

  def unauthorized_user
    respond_to do |format|
      format.html { render_optional_error_file(401) }
      format.xml { head :unauthorized }
      format.js { 
        flash[:notice] = 'You need to sign in or sign up before continuing.'
        render :update do |page|
          page.redirect_to new_user_session_path
        end
      }
    end
  end
  
  def is_admin?
    if current_user.admin?
      return true
    end    
  end  
  
  def all_users_list
    @all_users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))    
  end
end
