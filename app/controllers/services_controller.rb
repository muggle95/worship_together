class ServicesController < ApplicationController
  def new
    @service = Service.new
  end #end new
  
  def create
    @service = Service.new(service_params)
    if @service.save
      flash[:success] = "Service created"
      redirect_to @service
	  else
      flash.now[:danger] = "Unable to create service"
	    render 'new'
    end #end if-else
  end #end create
  
  def edit
    @service = Service.find(params[:id])
    rescue
      flash.now[:danger] = "Unable to find service"
    redirect_to services_path
  end #end edit
  
  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      flash.now[:success] = "The service has been updated"
      redirect_to service_path(@service)
	  else
      flash.now[:danger] = "Unable to edit the service"
        render 'edit'
	  end
    rescue
    flash.now[:danger] = "Unable to find service"
    redirect_to services_path
  end #end update
  
  def index
    @services = Service.all
  end #end index
  
  def show
    @service = Service.find(params[:id])
    @ride = @service.rides.build
    rescue
    flash[:danger] = "Unable to find service"
    redirect_to services_path
  end #end show
  
  def destroy
    @service = Service.find(params[:id])
    if @service.destroy
      flash[:success] = "Service deleted"
      redirect_to services_path
    else
      flash.now[:danger] = "service not deleted"
    end
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