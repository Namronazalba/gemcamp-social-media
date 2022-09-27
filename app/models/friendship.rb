class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_uniqueness_of  :user_id, scope: :friend

  include AASM
  aasm column: :status do
    state :pending, initial: true
    state :confirmed, :unfriended

    event :confirm do
      transitions from: :pending, to: :confirmed
    end
  end
end
