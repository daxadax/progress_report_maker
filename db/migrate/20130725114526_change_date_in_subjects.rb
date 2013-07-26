class ChangeDateInSubjects < ActiveRecord::Migration
  def up
    change_column :subjects, :start_date, :string
    change_column :subjects, :end_date, :string
  end

  def down
    change_column :subjects, :start_date, :date
    change_column :subjects, :end_date, :date
  end
end