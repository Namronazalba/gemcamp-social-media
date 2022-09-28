class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = current_user.posts.order(id: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to posts_path
    else
      flash[:alert] = "Post created failed!"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully!"
      redirect_to root_path
    else
      flash[:alert] = "Post failed to edit!"
      render :edit
    end
  end

  def show; end

  def destroy
    if @post.destroy
      flash[:notice] = "Post deleted successfully!"
    else
      flash[:alert] = "Post failed to delete!"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :content, :status)
  end

  def set_post
    @post = Post.find(params[:post_id] || params[:id])
    authorize @post
  end
end
