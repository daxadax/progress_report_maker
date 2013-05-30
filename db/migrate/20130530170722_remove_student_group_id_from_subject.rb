class RemoveStudentGroupIdFromSubject < ActiveRecord::Migration
  def up
    remove_column :subjects, :student_group_id
  end

  def down
    add_column :subjects, :student_group_id
  end
end
