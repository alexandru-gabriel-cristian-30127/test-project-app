class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in the user and redirect to profile page
      log_in user
      
      if params[:session][:remember_me] == '1'
        remember(user)
      else
        forget(user)
      end
      redirect_back_or user
      #remember user
      #redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
