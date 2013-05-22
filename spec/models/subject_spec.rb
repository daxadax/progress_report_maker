# == Schema Information
#
# Table name: subjects
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  student_group_id :integer
#  student_id       :integer
#  end_date         :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Subject do
  
  before(:each) do
    association_attr  
  end
  
  it "should create a new instance with valid attributes" do
    @student.subjects.create!(@subject_attr).should be_valid
  end
  
  describe "Student associations" do
    
    it "should have a student attribute" do
      @subject.should respond_to(:student)
    end
    
    it "should have the right associated student" do
      @subject.student_id.should == @student.id
      @subject.student.should == @student
    end 
    
  end
    
end
