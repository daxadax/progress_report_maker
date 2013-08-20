class AddIndexToEvaluations < ActiveRecord::Migration
  def change
    add_index :evaluations, :goal_id
    add_index :evaluations, :student_id
  end
end
