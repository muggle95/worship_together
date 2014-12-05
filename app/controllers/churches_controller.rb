class ChurchesController < ApplicationController
    def new
	@church = Church.new
	@church.services.build
    end

    def create
	@church = Church.new(church_params)
	@church.user = current_user
	if @church.save
	    flash[:success] = "#Church created"
	    redirect_to @church
	else
	    flash.now[:danger] = "Unable to create church"
	    render 'new'
	end
    end
  
  def edit
    @church = Church.find(params[:id])
  end
  
  def update
     @church = Church.find(params[:id])
      if @church.update(church_params)
        flash[:success] = "#Church edited"
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
