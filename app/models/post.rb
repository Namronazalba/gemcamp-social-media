class Post < ApplicationRecord
  belongs_to :user
  validates  :status, presence: true

  enum status: [:public_post, :friends, :private_post]
  mount_uploader :image, ImageUploader
end