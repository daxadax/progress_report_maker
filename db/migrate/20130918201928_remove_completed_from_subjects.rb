class RemoveCompletedFromSubjects < ActiveRecord::Migration
  def change
    remove_column :subjects, :completed, :boolean
  end
end
