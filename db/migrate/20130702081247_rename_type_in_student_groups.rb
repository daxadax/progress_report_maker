class RenameTypeInStudentGroups < ActiveRecord::Migration
  def up
    rename_column :student_groups, :type, :type_of_group
  end

  def down
    rename_column :student_groups, :type_of_group, :type
  end
end
