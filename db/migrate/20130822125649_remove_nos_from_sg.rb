class RemoveNosFromSg < ActiveRecord::Migration
  def up
    add_column :student_groups, :number_of_students, :integer
  end
  
  def down
    remove_column :student_groups, :number_of_students, :integer
  end
end
