class AddIndexesToModels < ActiveRecord::Migration
  def change
    add_index :subjects, :student_group_id
    add_index :students, :student_group_id
    add_index :goals, :subject_id
    add_index :evaluations, :goal_id
  end
end
