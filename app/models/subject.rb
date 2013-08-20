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
  attr_accessible :name, :start_date, :end_date, :contact_time

  belongs_to :student_group
  has_many   :goals, dependent: :destroy
  
  accepts_nested_attributes_for :goals  
  
  validates :student_group_id, :name, :start_date, :end_date, :contact_time, presence: true
  validates :contact_time, numericality: true
  
  before_save { |subject| subject.name  = name.titleize }
  
  # methods
  
  # => "x weeks"
  def weeks_left
    time = (self.end_date.to_time - Date.today.to_time).round/1.week
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
    self.goals.each do |goal|
      goal.evaluations.all.each do |eval|
        score = eval.score
        @scores << score
      end
    end
    # get average of scores and round to two decimal places
    average = @scores.inject{ |sum, el| sum + el }.to_f / @scores.size
    average.round(2)
  end
  
end