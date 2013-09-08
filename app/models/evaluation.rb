# == Schema Information
#
# Table name: evaluations
#
#  id          :integer          not null, primary key
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  student_id  :integer
#  goal_id     :integer
#  eval_number :integer
#

class Evaluation < ActiveRecord::Base
  attr_accessible :score, :student_id, :goal_id, :eval_number

  belongs_to :student
  belongs_to :goal

  validates :score, :goal_id, :student_id, presence: :true
  # validate  :date_scope
  
  # methods
  
  def set_eval_number
    last_eval = Evaluation.last.eval_number
    if last_eval != nil
      last_eval += 1
    else 
      last_eval = 1   
    end 
  end
  
  # stackoverflow.com/a/7394804/2128691     
  def next
    Evaluation.where("id > ?", id).order("id ASC").first
  end
  
  # def avg_for_eval(i)
  #   self.evals.select
  #     # where(:date => array_of_dates).
  #     #         reduce(Hash.new(0)){ |h, r| h[r.date] = r.count;h}
  #   #eval["#{i}"] = self.evals.fetch(self.eval_number_set(i))
  #   # evals = self.evals.fetch(self.eval_number_set(i), "x")
  #   # (scores.sum.to_f / scores.size).round(2)
  # end
  

  private

  # limit of one evaluation per student group per day
  # def date_scope
  #     if Evaluation.where("goal_id = ? AND student_id = ? AND DATE(created_at) = DATE(?)", self.goal_id, self.student_id, Time.now).all.any?
  #       errors.add(:goal_id, "You can only evaluate a class once per day")
  #     end
  #   end
  

end
