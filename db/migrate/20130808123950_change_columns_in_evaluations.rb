class ChangeColumnsInEvaluations < ActiveRecord::Migration
  def change
    remove_column :evaluations, :date, :date
    remove_column :evaluations, :student_id, :integer
    remove_column :evaluations, :goal_id, :integer
    add_column :evaluations, :evaluable_id, :integer
    add_column :evaluations, :evaluable_type, :string
  end
end