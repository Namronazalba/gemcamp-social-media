class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    friends_id = current_user.friendships.confirmed.pluck(:friend_id) + current_user.inverse_friendships.confirmed.pluck(:user_id)
    own_post = current_user.posts.where.not(status: :public_posts)
    public_post = Post.public_post
    friends_post = Post.friends.where(user_id: friends_id)

    @posts =  own_post + public_post + friends_post
  end
end
