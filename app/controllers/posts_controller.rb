class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params.merge(user: current_user))
    if @post.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?
  end

  def edit
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?
    return render_not_found(:forbidden) if @post.user != current_user
  end

  def update
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?
    return render_not_found(:forbidden) if @post.user != current_user
    
    @post.update_attributes(post_params)

    if @post.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?
    return render_not_found(:forbidden) if @post.user != current_user
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :message)
  end
end
