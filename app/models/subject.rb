# == Schema Information
#
# Table name: subjects
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  end_date         :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_group_id :integer
#  start_date       :date
#  contact_time     :integer
#

class Subject < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date, :contact_time

  belongs_to :student_group
  has_many   :goals, dependent: :destroy
  
  accepts_nested_attributes_for :goals  
  
  validates :student_group_id, :name, :start_date, :end_date, :contact_time, presence: true
  validates :contact_time, numericality: true
  
end
