# == Schema Information
#
# Table name: student_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StudentGroup < ActiveRecord::Base
  attr_accessible :name, :number_of_students, :type_of_group, :students_attributes
  
  belongs_to :user
  has_one    :age, dependent: :destroy
  has_many   :students, dependent: :destroy
  
  accepts_nested_attributes_for :students, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
  VALID_TYPES = ["young learners class (0-6)", "primary class (7-12)", "secondary class (13-17)", "adult class (18+)", "children's sport team", "adult's sport team"]
  
  validates :user_id,          presence: true
  validates :name,             presence: true
  validates :type_of_group,    inclusion: { :in => VALID_TYPES,
                                            :message => "%{value} is not a valid type" }
  
  before_save { |group| group.name = name.humanize }
  
end
