class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  def up
    User.all.update_all confirmed_at: DateTime.now
  end
end
