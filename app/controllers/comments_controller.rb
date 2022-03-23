class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @item = Item.find(params[:item_id])
      CommentChannel.broadcast_to @item, { comment: @comment, user: @comment.user }
    else
      redirect_to item_path(params[:item_id])
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:contents).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
