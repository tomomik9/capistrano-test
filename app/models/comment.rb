class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :title, presence: true
  validates :body, presence: true
end
