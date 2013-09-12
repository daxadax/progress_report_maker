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
  include ActionView::Helpers
  
  attr_accessible :goal
  
  belongs_to :subject
  has_many :evaluations, dependent: :destroy
  
  validates :subject_id, :goal, presence: true
  
  before_save { |g| g.goal = goal.humanize }
  
  # methods
  
  # http://stackoverflow.com/a/1341318/2128691
  def avg
    @scores = []
    # pull all evaluation data for model and populate @scores
    self.evaluations.all.each do |eval|
      score = eval.score
      @scores << score
    end
    average(@scores)
  end
  
  def evals
    self.evaluations.order("eval_number").group_by(&:student_id)
  end
  
  def evals_by_number
    self.evaluations.order("eval_number").group_by(&:eval_number)    
  end
  
  def evals_by(student)
    self.evals.map do |student_id, evals|
      evals.select {student_id == student.id}.map do |eval|
        eval.score
      end
    end    
  end
  
  def evals_for_student(student, i)
    @evals = []
    self.evals.values.each do |eval|
      @evals << eval.keep_if { |e| e.student_id == student.id }
    end
    @evals = @evals.reject { |array| array.empty? }.first
    @evals[i].score if @evals[i]
  end
  
  def avg_for(student)
    scores = []
    self.evals.map do |student_id, evals|
      evals.select {student_id == student.id}.each do |eval|
        scores << eval.score
      end  
    end    
    (scores.sum.to_f / scores.size).round(2)
  end
  
  def eval_avg(i)
    scores = []
    evals = self.evals_by_number.values[i]
    unless evals.blank? 
      for eval in evals
        scores << eval.score
      end
    end
    (scores.sum.to_f / scores.size).round(2)  
  end
  
  def eval_count
    self.evals_by_number.keys.size
  end
  
end