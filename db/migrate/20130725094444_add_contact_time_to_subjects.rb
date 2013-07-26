class AddContactTimeToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :contact_time, :integer
  end
end
