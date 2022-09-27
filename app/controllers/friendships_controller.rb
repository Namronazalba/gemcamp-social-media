class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [:destroy, :confirm]
  before_action :set_inverse_friendship, only: :destroy

  def index
    friend_ids = current_user.friendships.where(status: [:confirmed, :pending]).pluck(:friend_id)
    user_ids = current_user.inverse_friendships.where(status: [:confirmed, :pending]).pluck(:user_id)
    @users =  User.where.not(id: current_user.id).where.not(id: friend_ids + user_ids)
    @friendships = current_user.friendships.pending
    # @inverse_friendships = current_user.inverse_friendships.pending

    # @friends = current_user.friendships.confirmed
    # @inverse_friends = current_user.inverse_friendships.confirmed
  end

  def create
    friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if friendship.save
      flash[:notice] = 'Friendship request sent!'
      redirect_to friendships_path
    else
      flash[:alert] = 'You already send request to this person!'
      return redirect_to friendships_path
    end
  end

  def destroy
    if @friendships.destroy
      flash[:notice] = "Request cancelled successfully!"
    else
      flash[:alert] = "Cancel failed!"
    end
    redirect_to friendships_path
  end

  def confirm
    if @friendships.confirm!
      flash[:notice] = "You are now friends!"
    else
      flash[:alert] = "Failed to confirm!"
    end
    redirect_to friendships_path
  end

  private

  def set_friendship
    @friendships = Friendship.find(params[:friendship_id] || params[:id])
  end

  def set_inverse_friendship
    @inverse_friendships = Friendship.find(params[:user_id] || params[:id])
  end
end
