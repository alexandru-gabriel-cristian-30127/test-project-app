class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_or_manager_user, only: :destroy
  # before_action :manager_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to YourFitnessTracker!"
      #handle a save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    # this line only pulls the releant user out of the database
    # @user = User.find(params[:id]) #this step is done in the correct_user before filter
  end
  
  def update
    if @user.update(user_params)
      #update the user with the new data
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # Before filters
    
    # Confirms a correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user
    def admin_or_manager_user
      redirect_to(root_url) unless (current_user.admin? || current_user.manager?)
    end
    
    # def manager_user
    #   redirect_to(root_url) unless current_user.manager?
    # end
    
  
end
