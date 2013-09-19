class AddCompletedToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :completed, :boolean, default: false
  end
end
