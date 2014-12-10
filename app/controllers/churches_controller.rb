class ChurchesController < ApplicationController
  def new
	  @church = Church.new
	  @church.services.build
    unless current_user
      flash[:danger] = "You must be logged in to create a church"
      redirect_to login_path
    end
  end

  def create
    unless current_user
      flash[:danger] = "You must be logged in to create a church"
      redirect_to login_path
    end
	  @church = Church.new(church_params)
	  @church.user = current_user
    if(@church.user)
	    if (@church.save)
	      flash[:success] = "Church created"
	      redirect_to @church
      else #else if (@church.save)
	      flash.now[:danger] = "Unable to create church"
	      render 'new'
      end #end if (@church.save)
    else #else if @church.user exists
      flash[:danger] = "You must be logged in to create a church"
      redirect_to login_path
    end #end if @church.user
  end #end create
  
  def edit
    @church = Church.find(params[:id])
    if (current_user)
      if(@church)
        unless(@church.user == current_user)
          flash[:danger] = "You are not authorized to edit that church"
          redirect_to root_path #the user is not authorized to edit this church.
        end
      end
    else
      flash[:danger] = "You must be logged in to edit a church"
      redirect_to login_path
    end
    rescue
	    flash[:danger] = "Unable to find church"
      redirect_to root_path
  end
  
  def update
     @church = Church.find(params[:id])
      if @church.update(church_params)
        flash[:success] = "Church edited"
	      redirect_to @church
	    else
        flash.now[:danger] = "Unable to modify church"
        render 'edit'
	    end
  end
  
  def index
    @churches = Church.all
  end
  
  def show
    	@church = Church.find(params[:id])
    rescue
	  flash[:danger] = "Unable to find church"
    redirect_to root_path
  end
  
  def destroy
    @church = Church.find(params[:id])
    @user = @church.user
    if @user
      if(@church.destroy)
        flash[:success] = "Church deleted"
        redirect_to root_path
      else
        flash[:danger] = "Found not deleted"
        puts "church #{:id} was found but not deleted?"
        redirect_to root_path
      end
    else
      flash[:danger] = "You are not authorized to delete this church"
      redirect_to root_path
    end
    rescue
	  flash[:danger] = "Unable to find church"
    redirect_to root_path
  end

    private

    def church_params
	params.require(:church).permit(:name,
				       :web_site,
				       :description,
				       :picture,
               :users,
				       services_attributes: [ :start_time,
							      :finish_time,
							      :location,
                    :day_of_week,
                    :id] )
    end
end
