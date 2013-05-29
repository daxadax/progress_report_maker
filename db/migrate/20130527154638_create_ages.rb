class CreateAges < ActiveRecord::Migration
  def change
    create_table :ages do |t|
      t.integer :student_group_id
      t.string :age_group

      t.timestamps
    end
  end
end
