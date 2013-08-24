class AddIndexToEvaluations < ActiveRecord::Migration
  def change
    add_index :evaluations, :student_id
  end
end
