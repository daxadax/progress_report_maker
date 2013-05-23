class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.string :characteristic
      t.integer :student_id

      t.timestamps
    end
  end
end
