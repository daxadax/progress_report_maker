class RemoveNosFromSg < ActiveRecord::Migration
  def change
    remove_column :student_groups, :number_of_students, :integer
  end
end
