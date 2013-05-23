# == Schema Information
#
# Table name: characteristics
#
#  id             :integer          not null, primary key
#  characteristic :string(255)
#  student_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Characteristic < ActiveRecord::Base
  attr_accessible :characteristic
  
  belongs_to :student
  
end
