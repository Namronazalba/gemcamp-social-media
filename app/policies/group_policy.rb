class GroupPolicy < ApplicationPolicy

  def update?
    user == @record.user
  end

  def destroy?
    user == @record.user
  end

  def join?
    user != @record.user
  end

  def member?

  end
end
