# == Schema Information
#
# Table name: student_groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  subject     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string(255)
#  time_period :integer
#

class StudentGroup < ActiveRecord::Base
  attr_accessible :name, :subject, :type, :time_period
 
  validates :name,        :presence  => true,
                          :length    => 3..40
                         
  validates :subject,     :presence  => true,
                          :length    => 3..40
                          
  validates :type,        :presence  => true,
                          :length    => 3..40
                          
  validates :time_period, :presence  => true
  
end
