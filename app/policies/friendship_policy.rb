class FriendshipPolicy < ApplicationPolicy
  def pending
    record.pending == user
  end

  def confirmed
    record.confirmed == user
  end
end
