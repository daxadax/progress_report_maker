#http://stackoverflow.com/questions/8627156/adding-default-true-to-boolean-in-existing-rails-column

class AddDefaultToAdmin < ActiveRecord::Migration
  def up
      change_column :users, :admin, :boolean, default: false
  end

  def down
      change_column :users, :admin, :boolean, default: nil
  end
end
