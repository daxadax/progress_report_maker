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
    @student.subjects.new(@subject_attr).should be_valid
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
  
  describe "Goal associations" do
    
    it "should have a goal attribute" do
      @subject.should respond_to(:goals)
    end
    
    it "should destroy associated goals" do
      @subject.destroy
      [@goal, @goal2].each do |goal|
        Goal.find_by_id(goal.id).should be_nil
      end
    end
    
  end
    
end
