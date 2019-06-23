concern :Commentable do
  included do
    has_many :comments, as: :commentable
  end
end
