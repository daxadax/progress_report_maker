class CreateStudentGroups < ActiveRecord::Migration
  def change
    create_table :student_groups do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :student_groups, :user_id
  end
end
