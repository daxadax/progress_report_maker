# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  goal       :string(255)
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  default    :boolean
#

class Goal < ActiveRecord::Base
  attr_accessible :goal
  
  belongs_to :subject
  
  validates :subject_id, presence: true
  
end
