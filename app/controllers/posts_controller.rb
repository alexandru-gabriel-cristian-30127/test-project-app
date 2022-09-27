class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your data has successfully been uploaded"
      redirect_to root_url
    end
  end
  
  def destroy
    # @post.destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  def post_params
    params.require(:post).permit(:date, :time, :distance)
  end
  
  # def correct_user
  #   @post = current_user.posts.find_by(id: params[:id])
  #   redirect_to root_url if @post.nil?
  # end
  
  def correct_user
    redirect_to root_url unless current_user.admin? || current_user.posts.find_by(id: params[:id])
  end
end
