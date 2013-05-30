# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  gender           :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_group_id :integer
#

class Student < ActiveRecord::Base
  attr_accessible :gender, :name
  
  belongs_to :student_group
  has_many   :subjects
  has_many   :characteristics, dependent: :destroy
  
  VALID_GENDERS = %w(Male Female Transgender)
  
  validates :student_group_id, presence: true
  validates :gender,           inclusion: { :in => VALID_GENDERS,
                                            :message => "%{value} is not a valid gender" }
  
end