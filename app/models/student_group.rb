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
  attr_accessible :name
  
  belongs_to :user
  has_one    :age, dependent: :destroy
  has_many   :students, dependent: :destroy
  
end
