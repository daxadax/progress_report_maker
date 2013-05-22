# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  gender           :binary(3)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_group_id :integer
#

class Student < ActiveRecord::Base
  attr_accessible :gender, :name
  
  belongs_to :student_group
  has_many :subjects
  
end
