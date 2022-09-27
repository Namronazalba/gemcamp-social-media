class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [:destroy, :confirm]

  def index
    @friendships = current_user.friendships.pending
    @inverse_friendships = current_user.inverse_friendships.pending
  end

  def destroy
    if @friendships.destroy
      flash[:notice] = "Request cancelled successfully!"
    else
      flash[:alert] = "Cancel failed!"
    end
    redirect_to friend_requests_path
  end

  def confirm
    if @friendships.confirm!
      flash[:notice] = "You are now friends!"
    else
      flash[:alert] = "Failed to confirm!"
    end
    redirect_to friend_requests_path
  end

  private

  def set_friendship
    @friendships = Friendship.find(params[:friend_request_id] || params[:id])
  end

end
