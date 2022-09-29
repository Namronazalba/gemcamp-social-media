class Group < ApplicationRecord
  belongs_to :user
  has_many :group_posts
  has_many :members
  validates :name, :description, :banner, :privacy, presence: true
  enum privacy: [:public_group, :hidden]
  mount_uploader :banner, ImageUploader
end
