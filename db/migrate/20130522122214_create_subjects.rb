class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :student_group_id
      t.integer :student_id
      t.date :end_date

      t.timestamps
    end
    add_index :subjects, :student_group_id
  end
end
