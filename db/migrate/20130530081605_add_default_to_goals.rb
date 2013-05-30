class AddDefaultToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :default, :boolean
  end
end
