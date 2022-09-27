class FriendsListController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: :destroy
  before_action :set_inverse_friendship, only: :destroy

  def index
    @friends = current_user.friendships.confirmed
    @inverse_friends = current_user.inverse_friendships.confirmed
  end

  def destroy
    if @friendships.destroy
      flash[:notice] = "Successfully unfriend!"
    else
      flash[:alert] = "Cancel failed!"
    end
    redirect_to friends_list_index_path
  end

  def set_friendship
    @friendships = Friendship.find(params[:friendship_id] || params[:id])
  end

  def set_inverse_friendship
    @inverse_friendships = Friendship.find(params[:user_id] || params[:id])
  end
end
