class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @post = current_user.post.build(post_params)
    if @post.save
      flash[:success] = "Your data has successfully been uploaded"
      redirect_to root_url
    end
  end
  
  def destroy
  end
  
  def post_params
    params.require(:post).permit(:date, :time, :distance)
  end
end
