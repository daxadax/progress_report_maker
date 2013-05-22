class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.binary :gender, limit: 3

      t.timestamps
    end
  end
end
