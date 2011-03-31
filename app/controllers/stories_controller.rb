class StoriesController < ApplicationController
  # GET /stories
  # GET /stories.xml
  def index
    @stories = Story.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @project = Project.find(params[:project_id])
    @project_users = @project.users    
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
    @project_users = @story.project.users
    respond_to do |format|
      format.html {  }
      format.js {
        render :update do |page|
          page['#story-edit-section-dialog-form'].dialog('open');
          page['#story-edit-section'].html(render(:partial => "edit_story")) 
        end
      }
    end        
  end

  # POST /stories
  # POST /stories.xml
  def create
    @project = Project.find(params[:project_id])
    @project_users = @project.users    
    @story = @project.stories.build(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to(project_path(@project), :notice => 'Story was successfully created.') }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])
    @project_users = @story.project.users
    
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to(@story) }
        format.js {
          render :update do |page|
            page.reload;
            # page << "Message.notice('Story was successfully updated.')"
          end          
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js {
          render :update do |page|
            page['#story-edit-section-dialog-form'].dialog('open');
            page['#story-edit-section'].html(render(:partial => "edit_story")) 
          
            page['#edit_story_errors'].show();
            page['#edit_story_errors'].html("#{@story.errors.full_messages}");
          end          
        }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(stories_url) }
      format.xml  { head :ok }
    end
  end
end
