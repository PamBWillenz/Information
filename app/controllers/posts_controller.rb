class PostsController < ApplicationController

  def index
  end

  def new
    @post = Post.new
  end

  def create
    #@post = current_user.posts.create(post_params)
    @post = Post.create(post_params.merge(user: current_user))
    if @post.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.blank?
      render text: 'Not Found', status: :not_found
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :message)
  end
end
