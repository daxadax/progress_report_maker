class ChangeGenderInStudents < ActiveRecord::Migration

  def change
    change_column :students, :gender, :string, limit: nil
  end

end
