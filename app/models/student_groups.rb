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

class StudentGroups < ActiveRecord::Base
  attr_accessible :name, :subject
end
