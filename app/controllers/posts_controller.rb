class PostsController < ApplicationController

  before_action :ensure_current_user, except: [:index, :show]
  before_action :only_edit_own_posts, except: [:index, :show, :new, :create]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
    @comments = Comment.where(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post = Post.last
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.destroy(params[:id])
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
  end


  def only_edit_own_posts
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      flash[:notice] = "You are not authorized to edit this content"
      redirect_to posts_path
    end
  end

end
