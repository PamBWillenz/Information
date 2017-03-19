class CommentsController < ApplicationController
  #before_action :authenticate_user!, only: [:create]

  def create
    @post = Post.find_by_id(params[:post_id])
    return render_not_found if @post.blank?

    @post.comments.create(comment_params.merge(user: current_user))
    redirect_to root_path
  end

  private

  def render_not_found(status=:not_found)
    render text: "#{status.to_s.titleize} :(", status: status
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
