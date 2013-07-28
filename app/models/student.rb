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
  has_many   :characteristics, dependent: :destroy
  
  accepts_nested_attributes_for :characteristics
  
  VALID_GENDERS = %w(Male Female Transgender)
  
  validates :student_group_id, presence: true
  validates :gender,           inclusion: { :in => VALID_GENDERS,
                                            :message => "%{value} is not a valid gender" }
  
  before_save { |student| student.name = name.titleize }
  
  # methods
  
  # checks how long student since student has been created and returns "x weeks"
  def student_for_weeks
    time = (Time.now - self.created_at.to_time).round/1.week
    if time < 1
      "less than 1 week"
    else
      "#{time} weeks" 
    end
  end
         
end