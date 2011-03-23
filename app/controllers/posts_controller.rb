class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    if current_user
       @post.user_id = current_user.id
    end
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to(root_path, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(root_url, :notice => 'Post was successfully removed.') }
      format.xml  { head :ok }
    end
  end
  
  def rate_post
    @post = Post.find(params[:id])
    Rating.delete_all(["rateable_type = 'Post' AND rateable_id = ? AND user_id = ?", 
          @post.id, current_user.id])        
    rating = Rating.new(:rating => params[:rating], :user_id => current_user.id)
    if @post.ratings << rating 
    
      respond_to do |format|
        
        format.html { redirect_to home_index_path }
        format.js{
          render :update do |page|            
            page["#post-rating-#{@post.id}"].html render(:partial => 'home/post_ratings', :locals =>{:p => @post})
            page <<  "$('#feature-post-#{@post.id}').effect('highlight', {}, 10000);"   
          end
        }
      end
    else
      respond_to do |format|
        format.html{
          flash[:notice] = "Rating range must be with in 0 to 5"
          redirect_to root_path
        }
        format.js{
          render :update do |page|
            page << "Message.notice('Rating range must be with in 0 to 5')";
          end
        }
      end      
    end     
  end
  
end
