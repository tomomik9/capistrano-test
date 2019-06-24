class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  include Commentable
  validates :title, presence: true
  validates :memo, presence: true
end
