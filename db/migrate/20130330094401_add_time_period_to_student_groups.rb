class AddTimePeriodToStudentGroups < ActiveRecord::Migration
  def change
    add_column :student_groups, :time_period, :integer
  end
end
