# == Schema Information
#
# Table name: evaluations
#
#  id         :integer          not null, primary key
#  score      :integer
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :integer
#  goal_id    :integer
#

require 'spec_helper'

describe Evaluation do

  before(:each) do
    association_attr  
  end
  
  it "should create a new instance with valid attributes" do
    @eval.should be_valid
  end
  
  describe "validations" do
    
    it "should have a student_id" do
      Evaluation.new(@eval_attr).should_not be_valid
    end
    
    it "should have a goal_id" do
      Evaluation.new(@eval_attr).should_not be_valid
    end
    
    it "should have a score" do
      Evaluation.create(date: Date.today-2, score: "").should_not be_valid
    end
    
    it "should have a date" do
      Evaluation.create(score: 3, date: "").should_not be_valid
    end
    
  end
  
  describe "student associations" do
    
    it "should have a student attribute" do
      @eval.should respond_to(:student)
    end
    
    it "should have the right associated student" do
      @eval.student_id.should == @student.id
      @eval.student.should == @student
    end 
    
  end
  
  describe "goal associations" do
    
    it "should have a goal attribute" do
      @eval.should respond_to(:goal)
    end
    
    it "should have the right associated goal" do
      @eval.goal_id.should == @goal.id
      @eval.goal.should == @goal
    end
  
  end

end
