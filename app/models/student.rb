# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  gender     :string(255)
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ActiveRecord::Base
  attr_accessible :gender, :name, :notes
  
  validates :name,          :presence     => true,
                            :length       => 3..40
                            
  validates :gender,        :presence     => true
  
end
