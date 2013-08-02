class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :score
      t.date :date

      t.timestamps
    end
  end
end
