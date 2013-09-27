# == Schema Information
#
# Table name: subjects
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  end_date         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_group_id :integer
#  start_date       :string(255)
#  contact_time     :integer
#

class Subject < ActiveRecord::Base
  # include ::Averageable
  
  attr_accessible :name, :start_date, :end_date, :contact_time

  belongs_to :student_group
  has_many   :goals, dependent: :destroy
  
  accepts_nested_attributes_for :goals  
  
  validates :student_group_id, :name, :start_date, :end_date, :contact_time, presence: true
  validates :contact_time, numericality: true
  
  before_save { |subject| subject.name  = name.titleize }
  
  # scopes
  
  scope :completed, ->{where("end_date <= ?", Time.now)}
  
  # methods
  
  # => "x weeks"
  def weeks_left
    time = (self.end_date.to_time - Date.today.to_time).round/1.week
    if time < 0
      "completed"
    elsif time < 1
      "less than 1 week"
    elsif time == 1
      "1 week"
    else
      "#{time} weeks" 
    end
  end
  
  def weeks_status
    time = (self.end_date.to_time - Date.today.to_time).round/1.week
    if time < 0
      :complete
    elsif time < 1 
      :struggle
    elsif time <= 4
      :meet
    else
      ""
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
    # pull all evaluation data for model and populate scores
    self.goals.each do |goal|
      goal.evaluations.all.each do |eval|
        score = eval.score
        scores << score
      end
    end
    # get average of scores and round to two decimal places
    average(scores)
  end
  
  # finds the subject average for a given student
  def avg_for(student)
    scores = []
    self.goals.map do |goal|
      goal.evals.map do |student_id, evals|
        evals.select {student_id == student.id}.map do |eval|
          scores << eval.score
        end
      end
    end
    average(scores)
  end
  
  def avg_to_words(average)
    if average >= 3.5
      "Exceeds expectations"
    elsif (2.75..3.5).include? average 
      "Meets expectations"
    else
      "Struggling"
    end  
  end
  
  def status(average)
    if average >= 3.5
      :exceed
    elsif (2.75..3.5).include? average 
      :meet
    else
      :struggle
    end
  end
  
  def evals
     evals = self.goals.first.evaluations.order("eval_number").group_by(&:eval_number)
   end  
   
   # counts the number of times a subject has been evaluated
   def eval_count
     self.evals.keys.size
   end
  
end
