class CreateStudentGroups < ActiveRecord::Migration
  def change
    create_table :student_groups do |t|
      t.string :name
      t.string :subject

      t.timestamps
    end
  end
end
