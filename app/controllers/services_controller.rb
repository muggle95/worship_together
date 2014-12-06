class ServicesController < ApplicationController
  def new
  end #end new
  
  def create
  end #end create
  
  def edit
  end #end edit
  
  def update
  end #end update
  
  def index
  end #end index
  
  def show
    @service = Service.find(params[:id])
    rescue
    flash[:danger] = "Unable to find service"
    redirect_to services_path
  end #end show
  
  def destroy
  end #end destroy
  
  private

  def service_params
    params.require(:service).permit(
      :church,
      :start_time,
			:finish_time,
		  :location,
      :day_of_week,
      :id)
  end #end service params
  
end #end class