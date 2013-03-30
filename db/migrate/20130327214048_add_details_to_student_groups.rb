class AddDetailsToStudentGroups < ActiveRecord::Migration
  def change
    add_column :student_groups, :type, :string
    add_column :student_groups, :period, :date
  end
end
