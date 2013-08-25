class AddEvaluationNumberToEvaluations < ActiveRecord::Migration
  def up
    add_column :evaluations, :eval_number, :integer
    add_index :evaluations, :eval_number
  end
  
  def down
    remove_column :evaluations, :eval_number, :integer
    remove_index :evaluations, :eval_number    
  end  
end
