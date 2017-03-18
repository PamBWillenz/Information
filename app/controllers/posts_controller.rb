class PostsController < ApplicationController

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :message)
  end
end
