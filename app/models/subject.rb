# == Schema Information
#
# Table name: subjects
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  student_group_id :integer
#  student_id       :integer
#  end_date         :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Subject < ActiveRecord::Base
  attr_accessible :end_date, :name

  belongs_to :student
  has_many   :goals
end
