class AddTypeToStudentGroups < ActiveRecord::Migration
  def change
    add_column :student_groups, :type, :string
  end
end
