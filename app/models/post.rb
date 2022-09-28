class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates  :status, presence: true

  enum status: [:public_post, :friends, :private_post]
  mount_uploader :image, ImageUploader
end