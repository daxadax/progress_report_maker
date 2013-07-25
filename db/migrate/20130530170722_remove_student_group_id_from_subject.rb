class RemoveStudentGroupIdFromSubject < ActiveRecord::Migration
  def up
    remove_column :subjects, :student_group_id
  end

  def down
    remove_column :subjects, :student_id, :integer
    add_column :subjects, :student_group_id, :integer
  end
end
