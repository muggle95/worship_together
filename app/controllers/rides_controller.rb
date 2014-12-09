class RidesController < ApplicationController
  def index
    order_param = (params[:order] || :Date).to_sym
	  ordering = case order_param
      when :Date
		       :date
	    when :Service
		       :service_id
      end
	  @rides = Ride.order(ordering)
  end
  
  def new
    @ride = Ride.new
  end
  
  def create
    @ride = Ride.new(ride_params)
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
      flash.now[:danger] = "Unable to find ride"
      redirect_to rides_path
  end
  
  def edit
    @ride = Ride.find(params[:id])
    rescue
      flash.now[:danger] = "Unable to find ride"
      redirect_to rides_path
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
    if @ride.destroy
      flash[:success] = "Ride deleted"
      redirect_to rides_path
    else
      flash.now[:danger] = "Ride not deleted"
    end
  end
  
  private

  def user_params
    params.require(:ride).permit(:user, :service, :number_of_seats, :seats_available, :meeting_location, :vehicle, :date, :leave_time, :return_time, :picture)
  end
  
end
