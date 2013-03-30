class RemoveLengthFromStudentGroups < ActiveRecord::Migration
  def up
    remove_column :student_groups, :length
  end

  def down
    add_column :student_groups, :length, :integer
  end
end
