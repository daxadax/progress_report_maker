# == Schema Information
#
# Table name: evaluations
#
#  id         :integer          not null, primary key
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :integer
#  goal_id    :integer
#

class Evaluation < ActiveRecord::Base
  attr_accessible :score, :student_id, :goal_id

  belongs_to :student
  belongs_to :goal

  validates :score, :goal_id, :student_id, presence: :true
  
  # methods

end
