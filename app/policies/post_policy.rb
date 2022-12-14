class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(public_post: true).where(friends: true )
    end
  end

  def show?
    user_is_owner_of_record? || @record.public_post
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    user == @record.user
  end
end
