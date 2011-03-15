class SearchController < ApplicationController
  def index
    if params[:s].blank?
      respond_to do |format|
        flash[:notice] = 'Please give some appopriate text'
        format.html {
          redirect_to home_index_path
        }
      end
    else
      @results = Post.find(:all, :conditions =>["topic like? or description like? or code like?",  "%#{params[:s]}%","%#{params[:s]}%","%#{params[:s]}%"]).paginate :page => params[:page], :per_page => 5, :order => "created_at DESC"
    end
  end  
end
