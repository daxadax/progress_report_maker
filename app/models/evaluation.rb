# == Schema Information
#
# Table name: evaluations
#
#  id         :integer          not null, primary key
#  score      :integer
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :integer
#  goal_id    :integer
#

class Evaluation < ActiveRecord::Base
  attr_accessible :date, :score

  belongs_to :student
  belongs_to :goal

  validates :score, :date, :student_id, :goal_id, presence: :true
  
  # methods

end
