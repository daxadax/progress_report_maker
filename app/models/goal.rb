# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  goal       :string(255)
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  attr_accessible :goal
  
  belongs_to :subject
  
end
