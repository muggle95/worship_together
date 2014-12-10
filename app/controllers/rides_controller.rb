class RidesController < ApplicationController
  def index
    @service = Service.find(params[:service_id])
    order_param = (params[:order] || :Date).to_sym
	  ordering = case order_param
      when :Date
		       :date
	    when :Service
		       :service_id
      end
    @rides = @service.rides.order(ordering)
  end
  
  def new
    @service = Service.find(params[:service_id])
    @ride = @service.rides.build
  end
  
  def create
    @service = Service.find(params[:service_id])
    @ride = @service.rides.build(ride_params)
    @ride.user = current_user
    if @ride.save
      flash[:success] = "Ride has been created"
      redirect_to @ride
	  else
      flash.now[:danger] = "Unable to create new ride"
	    render 'new'
	  end
  end
  
  def show
    @ride = Ride.find(params[:id])
    rescue
      flash[:danger] = "Unable to find ride"
    redirect_to root_path
  end
  
  def edit
    @ride = Ride.find(params[:id])
    rescue
      flash[:danger] = "Unable to find ride"
    redirect_to root_path
  end
  
  def update
    @ride = Ride.find(params[:id])
    if @ride.update(ride_params)
      flash.now[:success] = "The ride\'s information has been updated"
      redirect_to ride_path(@ride)
    else
      flash.now[:danger] = "Unable to edit the ride"
      render 'edit'
    end
    rescue
      flash.now[:danger] = "Unable to find the ride"
	    redirect_to users_path
  end
  
  def destroy
    @ride = Ride.find(params[:id])
    @service = @ride.service
    if @ride.destroy
      flash[:success] = "Ride deleted"
      redirect_to @service
    else
      flash[:danger] = "Ride not deleted"
      redirect_to @ride
    end
  end
  
  private

  def ride_params
    params.require(:ride).permit(:user, :service, :number_of_seats, :seats_available, :meeting_location, :vehicle, :date, :leave_time, :return_time, :picture, :id)
  end
  
end
