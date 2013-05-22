class RemoveIndexfromSubject < ActiveRecord::Migration
  def change
    add_index :subjects, :student_id
  end
end
