class AddStudentGroupIdToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :student_group_id, :integer
  end
end
