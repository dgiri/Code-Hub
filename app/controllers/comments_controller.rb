class CommentsController < ApplicationController
  before_filter :authenticate_user!  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(params[:comment].merge({:user_id => current_user.id}))
    else
      @story = Story.find(params[:story_id])
      @comment = @story.comments.build(params[:comment].merge({:user_id => current_user.id}))      
    end
    respond_to do |format|
      if @comment.save       
        format.html {
          flash[:notice] = 'Comment was successfully created.'
          if params[:post_id]
            redirect_to(@comment)
          else
            redirect_to edit_story_path(@story)
          end               
        }
        format.js {
          render :update do |page|
            if params[:post_id]
              page << "$('#new_comment').resetForm();" 
              page.redirect_to post_path(@post)             
            else
              page['#Story-Comment-List'].html(render(:partial => "stories/comment_list", :locals => {:story => @story}))
              page <<  "$('#comment_item_#{@comment.id}').effect('highlight', {}, 10000);"
              page << "$('#Comment-Creation-From').resetForm();"              
            end
            page << "Message.notice('Comment was successfully posted.');"            
          end
        }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.js {
          render :update do |page|
            page['#dialog-form'].dialog('open');
            page['#new_comment_errors'].show();
            page['#new_comment_errors'].html("#{@comment.errors.full_messages}");
          end          
        }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
