class AddLengthToStudentGroups < ActiveRecord::Migration
  def change
    add_column :student_groups, :length, :integer
  end
end
