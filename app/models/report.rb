class Report < ApplicationRecord
  include Commentable
  validates:title, presence:true
end
