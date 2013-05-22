class AddColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_group_id, :integer
  end
end
