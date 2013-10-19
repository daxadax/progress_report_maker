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
  # include ::Averageable
  
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
  
=begin
 
   # currently not used! 
 
    # student avg per evaluation for ALL evaluations
   def avg_for_every_eval(i)
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
        ""
      end  
    end  
   end
=end
  
  #student avg per evaluation for 'i' most recent evaluations
  def avg_for_recent_evals(i)
    scores = []
    eval_number = self.reverse_eval_number_set(i)
    this_eval = self.evaluations.where("eval_number = ?", eval_number)
    for eval in this_eval 
      scores << eval.score
    end
    average(scores) unless average(scores).nan?
  end

  def recent_evals(i, goal)
    scores = []
    eval_number = self.reverse_eval_number_set(i)
    this_eval = self.evaluations.where("eval_number = ? AND goal_id = ?", eval_number, goal.id)
    for eval in this_eval 
      scores << eval.score
    end
    average(scores) unless average(scores).nan?
  end

  def group_eval_header(downfrom_i)
    eval_number = self.reverse_eval_number_set(downfrom_i)
    this_eval = self.evaluations.where("eval_number = ?", eval_number)
    this_eval.first.created_at.strftime("%d %b, %Y") unless this_eval.first.nil?
  end

  def evals
    @evals ||= self.evaluations.order("eval_number").group_by(&:eval_number)
    @evals
  end  
  
  # how many time student has been evaluated in total
  def eval_count
    self.evals.keys.size
  end
  
  # returns hash of student's evaluations ordered by Eval_Number for x subject
  def evals_for(subject)
    sub_ids = subject.goals.map(&:id)
    sub_evals = Evaluation.where('goal_id IN (?) AND student_id = ?', sub_ids, self.id).order("eval_number").group_by(&:eval_number)
  end
  
  
  def sub_eval_count(subject)
    self.evals_for(subject).keys.size
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