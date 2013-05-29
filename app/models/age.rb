# == Schema Information
#
# Table name: ages
#
#  id               :integer          not null, primary key
#  student_group_id :integer
#  age_group        :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Age < ActiveRecord::Base
  attr_accessible :age_group
  
  belongs_to :student_group
  
  VALID_AGE_GROUPS = ['Nursery (0-5)', 'Primary (6-10)', 'Secondary (11-16)', 'Adults (16+)', 'Mixed']
  
  validates :age_group, inclusion: { :in => VALID_AGE_GROUPS,
                                     :message => "%{value} is not a valid age group" }
end
