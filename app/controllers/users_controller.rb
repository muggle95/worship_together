class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit]
  before_action :ensure_admin, only: [:destroy]
  before_action :self_preservation, only: [:destroy]

  def index
	  @users = User.all
  end

  def new
    if current_user
      redirect_to root_path
    end
	  @user = User.new
  end

  def create
	  @user = User.new(user_params)
	  if @user.save
	    flash[:success] = "Welcome to the site, #{@user.name}"
	    redirect_to @user
	  else
	    flash.now[:danger] = "Unable to create new user"
	    render 'new'
	  end
  end

  def show
	  @user = User.find(params[:id])
    rescue
	  flash[:danger] = "Unable to find user"
	  redirect_to users_path
  end

    def edit
      @user = User.find(params[:id])
      unless (@user == current_user)
        flash[:danger] = "You may only edit your own information"
        redirect_to root_path
      end
      rescue
	      flash[:danger] = "Unable to find user"
	      redirect_to users_path
    end
  
  def update
    @user = User.find(params[:id])
    if params[:church_id]
      @user.church_id = params[:church_id]
      if @user.save
        flash[:success] = "Church attended"
        redirect_to @user.church
      else
        flash[:danger] = "Church could not be attended"
        redirect_to church_path(:church_id)
      end
    elsif params[:ride_id]
      @ride = Ride.find(params[:ride_id])
      if(@ride.seats_available >0)
        @user.rides << @ride
        @ride.seats_available = @ride.seats_available-1
        @user.save
        @ride.save
        flash[:success] = "Ride claimed"
        redirect_to @ride
      else
        flash[:danger] = "Ride could not be claimed"
        redirect_to @ride
      end
    else
      if @user.update(user_params)
        flash[:success] = "#{@user.name}, your information has been updated"
        redirect_to user_path(@user)
	    else
        flash.now[:danger] = "Unable to edit the user"
        render 'edit'
	    end
    end
    rescue
	    flash[:danger] = "Unable to find user"
	    redirect_to users_path
  end
  
  def destroy
    @user = User.find(params[:id])
    unless @user === current_user
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_path
    else
      flash[:danger] = "User not deleted"
      redirect_to user_path(@user)
    end
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :church_id, :ride_id, :id)
    end

    def ensure_user_logged_in
	unless current_user
	    flash[:warning] = 'Not logged in'
	    redirect_to login_path
	end
    end

   # def ensure_correct_user
	#@user = User.find(params[:id])
	#unless current_user?(@user)
	#    flash[:danger] = "Cannot edit other user's profiles"
	#    redirect_to root_path
	#end
  #  rescue
	#flash[:danger] = "Unable to find user"
	#redirect_to users_path
  #  end

    def ensure_admin
	unless current_user.admin?
    flash[:danger] = 'Only admins allowed to do that.'
	    redirect_to root_path
	end
    end
  
  def ensure_correct_user
 #   unless current_user === User.find(params[:id])
 #     flash[:danger] = 'You are not authorized to do that.'
#	    redirect_to root_path
#    end
  end
  
  def self_preservation
    if current_user === User.find(params[:id])
      flash[:danger] = 'You may not delete yourself.'
	    redirect_to root_path
    end
  end
    
  def ensure_user_logged_in
   unless current_user
     flash[:danger] = 'You must be logged in to do that.'
	   redirect_to root_path
   end
  end
  
end
