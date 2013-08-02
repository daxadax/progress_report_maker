class AddIdsToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :student_id, :integer
    add_column :evaluations, :goal_id, :integer
  end
end
