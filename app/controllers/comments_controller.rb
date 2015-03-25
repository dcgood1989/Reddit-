class CommentsController < ApplicationController
  before_action do
    @post = Post.find(params[:post_id])
  end
  before_action :ensure_current_user
  before_action :only_edit_own_comments, except: [:create]


  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to post_path(@post)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: @post.id)
  end

  def only_edit_own_comments
    @comment = Comment.find(params[:id])
    unless current_user.id == @comment.user_id
      flash[:notice] = "You are not authorized to edit this content"
      redirect_to posts_path
    end
  end

end
