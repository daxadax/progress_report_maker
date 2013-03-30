class RemovePeriodFromStudentGroups < ActiveRecord::Migration
  def up
    remove_column :student_groups, :period
  end

  def down
    add_column :student_groups, :period, :date
  end
end
