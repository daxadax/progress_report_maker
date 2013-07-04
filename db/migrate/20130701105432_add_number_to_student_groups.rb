class AddNumberToStudentGroups < ActiveRecord::Migration
  def change
    add_column :student_groups, :number_of_students, :integer
  end
end
