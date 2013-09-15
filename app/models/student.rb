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
  # include Averageable
  
  attr_accessible :gender, :name
  
  belongs_to :student_group
  has_many   :characteristics, dependent: :destroy
  has_many   :evaluations, dependent: :destroy
  
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
  
  def average(scores)
    # get average of scores and round to two decimal places
    average = scores.inject{ |sum, el| sum + el }.to_f / scores.size
    average.round(2)
  end
  
  # http://stackoverflow.com/a/1341318/2128691
  def avg
    scores = []
    # pull all evaluation data for model and populate @scores
    self.evaluations.all.each do |eval|
      score = eval.score
      scores << score
    end
    # get average of scores and round to two decimal places
    average(scores)
  end      
  
  # stackoverflow.com/a/7394804/2128691     
  def next
    Student.where("id > ?", id).order("id ASC").first
  end    

  def eval_number_set(index)
    numbers = self.student_group.students.first.evals.keys
    # numbers = Evaluation.where('student_id = ?', self.id).uniq.pluck(:eval_number)
    numbers[index]
  end
  
  def reverse_eval_number_set(index)
    numbers = self.student_group.students.first.evals.keys.reverse
    numbers[index]
  end
  
  def avg_for_eval(i)
    scores = []
    eval_number = self.reverse_eval_number_set(i)
    count_differential = (self.student_group.eval_count - self.eval_count) - i
    if self.student_group.eval_count == self.eval_count
      for eval in self.evals.values[i] 
        scores << eval.score
      end
      average(scores)
    else
      if self.evals.values[count_differential]
        for eval in self.evals.values[count_differential]
          scores << eval.score
        end
        average(scores)
      else
        "no data"
      end  
    end  
  end

  def evals
    evals = self.evaluations.order("eval_number").group_by(&:eval_number)
  end  
  
  def eval_count
    self.evals.keys.size
  end
  
  def evals_avg(number)
    evals = self.evals
    scores = []
    if evals.values[number]
      evals.values[number].each do |eval|
        scores << eval.score
      end
    end    
    average(scores)
  end
       
end