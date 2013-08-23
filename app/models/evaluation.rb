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
  # validate  :date_scope
  
  # methods

  private

  # limit of one evaluation per student group per day
  # def date_scope
  #     if Evaluation.where("goal_id = ? AND student_id = ? AND DATE(created_at) = DATE(?)", self.goal_id, self.student_id, Time.now).all.any?
  #       errors.add(:goal_id, "You can only evaluate a class once per day")
  #     end
  #   end
  

end
