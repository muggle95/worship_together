class ChurchesController < ApplicationController
    def new
	@church = Church.new
	@church.services.build
    end

  def create
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
      redirect_to login_path
    end #end if @church.user
  end #end create
  
  def edit
    @church = Church.find(params[:id])
    rescue
	    flash[:danger] = "Unable to find church"
      redirect_to churches_path
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
    redirect_to churches_path
  end
  
  def destroy
    @church = Church.find(params[:id])
    if(church.destroy(:id))
      flash[:success] = "Church deleted"
      redirect_to churches_path
    else
      puts "church #{:id} was found but not deleted?"
    end
    rescue
	  flash[:danger] = "Unable to find church"
    redirect_to churches_path
  end

    private

    def church_params
	params.require(:church).permit(:name,
				       :web_site,
				       :description,
				       :picture,
				       services_attributes: [ :start_time,
							      :finish_time,
							      :location,
                    :day_of_week,
                    :id] )
    end
end
