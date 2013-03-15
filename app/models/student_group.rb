# == Schema Information
#
# Table name: student_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subject    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StudentGroup < ActiveRecord::Base
  attr_accessible :name, :subject
 
  validates :name,        :presence      => true,
                          :length         => 3..40
                         
  validates :subject,     :presence      => true,
                          :length         => 3..40
end
