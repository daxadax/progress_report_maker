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
    # get average of scores and round to two decimal places
    average = @scores.inject{ |sum, el| sum + el }.to_f / @scores.size
    average.round(2)
  end
  
  def evals
    self.evaluations.order("eval_number").group_by(&:student_id)
  end
  
  def eval_avg(number)
    evals = self.evals
    scores = []
    evals.values[number].each do |eval|
      scores << eval.score
    end  
    (scores.sum.to_f / scores.size).round(2)
  end
  
  def evals_by_number
    self.evaluations.order("eval_number").group_by(&:eval_number)    
  end
  
  def evals_by_number_avg(number)
    evals = self.evals_by_number
    scores = []
    evals.values[number].each do |eval|
      scores << eval.score
    end
    (scores.sum.to_f / scores.size).round(2)  
  end
  
end
