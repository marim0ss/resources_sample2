class User < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, {presence: true}
  validates :email, {presence: true}
  validates :password, {presence: true }

end
