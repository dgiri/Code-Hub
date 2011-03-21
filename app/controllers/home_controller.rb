class HomeController < ApplicationController
  def index
    @posts = Post.paginate :page => params[:page], :order => "created_at DESC"
    # Post.paginate :page => params[:page], :order => "created_at DESC"
    # @popular_posts = Post.find(:all).sort_by {|fa| -fa.rating}
  end
end
