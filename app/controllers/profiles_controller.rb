class ProfilesController < ApplicationController
  def upload_image
    if !params[:user].blank?
      @user = User.find(params[:id])
    
      respond_to do |format|
        if @user.update_attribute(:avatar, params[:user][:avatar])
          flash[:notice] = 'User was successfully updated.'
          format.html { redirect_to root_path}
          format.xml  { head :ok }
        else
         flash[:notice] = 'User was not updated.'        
        end
      end
    else
      respond_to do |format|
        flash[:notice] = 'Please select a picture.' 
        format.html { redirect_to root_path}
      end      
    end    
  end  
  
  def upload_song
    if !params[:song].blank?
      @user = User.find(params[:id])
    
      respond_to do |format|
        @song = @user.songs.build(params[:song])
        if @song.save
          flash[:notice] = 'User was successfully updated.'
          format.html { redirect_to root_path}
          format.xml  { head :ok }
        else
         flash[:notice] = 'User was not updated.'        
        end
      end
    else
      respond_to do |format|
        flash[:notice] = 'Please select a picture.' 
        format.html { redirect_to root_path}
      end      
    end    
  end  
  
end
