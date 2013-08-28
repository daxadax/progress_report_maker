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
  
  # stackoverflow.com/a/7394804/2128691     
  def next
    Student.where("id > ?", id).order("id ASC").first
  end    

  def evals
    evals = self.evaluations.order("eval_number").group_by(&:eval_number)
  end
  
  def evals_avg(number)
    evals = self.evals
    scores = []
    evals.values[number].each do |eval|
      scores << eval.score
    end  
    (scores.sum.to_f / scores.size).round(2)  
  end
       
end