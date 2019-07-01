class Report < ApplicationRecord
  include Commentable
  validates:title, presence:true
  validates:memo, presence:true
end
