class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    
    respond_to do |format|
      format.html {  }
      format.js { 
        render :update do |page|
          unless params[:option]
            page <<  "$('#Task-Details_#{@task.id}').hide();"  
            page <<  "$('#Task-Options_#{@task.id}').hide();" 
            page <<  "$('#Task-Updation-Option_#{@task.id}').show();"
          else
            page <<  "$('#Task-Details_#{@task.id}').show();"  
            page <<  "$('#Task-Options_#{@task.id}').show();" 
            page <<  "$('#Task-Updation-Option_#{@task.id}').hide();"            
          end 
        end
      }
    end
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @story = Story.find(params[:story_id])
    @task = @story.tasks.build(params[:task].merge({:user => current_user}))

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to edit_story_path(@story) }
        format.js {
          render :update do |page|
            page['#Story-Task-List'].html(render(:partial => "task_list", :locals => {:story => @story}))
            page <<  "$('#task_item_#{@task.id}').effect('highlight', {}, 10000);"
            page <<  "$('#Task-Creation-From ').resetForm();"             
          end         
        }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.js {
          render :update do |page|
            page['#Story-Task-List'].html(render(:partial => "task_list", :locals => {:story => @task.story}))
            page <<  "$('#Task-Updation-Option_#{@task.id}').hide();"
            page['#Task-Details_#{@task.id}'].html('<%= escape_javascript(<%= t.description %>)')
            page <<  "$('#task_item_#{@task.id}').effect('highlight', {}, 10000);"             
          end         
        }        
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_task_status
    @task = Task.find(params[:task_id])
    @task.status ? @task.update_attribute(:status, false) : @task.update_attribute(:status, true)
    
    respond_to do |format|
      format.html { }
      format.js {
        render :update do |page|
          page['#Story-Task-List'].html(render(:partial => "task_list", :locals => {:story => @task.story}))
          page <<  "$('#task_item_#{@task.id}').effect('highlight', {}, 10000);" 
        end       
      }
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @story = @task.story
    @task.destroy

    respond_to do |format|
      format.html { redirect_to edit_story_path(@story) }
      format.js {
        render :update do |page|
           page['#Story-Task-List'].html(render(:partial => "task_list", :locals => {:story => @story}))
           # page.redirect_to edit_story_path(@story)
        end       
      }      
      format.xml  { head :ok }
    end
  end
end
