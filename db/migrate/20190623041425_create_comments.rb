class CreateComments < ActiveRecord::Migration[5.2]
  def up 
    change_table :comments do |t|
      t.references :commentable, polymorphic: true
    end
  end
end
