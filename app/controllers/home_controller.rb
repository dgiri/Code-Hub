class HomeController < ApplicationController
  def index
    @posts = Post.paginate :page => params[:page], :order => "created_at DESC"
    # Post.paginate :page => params[:page], :order => "created_at DESC"
    # @popular_posts = Post.find(:all).sort_by {|fa| -fa.rating}
    @all_users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))    
  end
end
