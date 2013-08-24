# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  goal       :string(255)
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  default    :boolean
#

require 'spec_helper'

describe Goal do
  
  before(:each) do
    association_attr  
  end
  
  it "should create a new instance with valid attributes" do
    @goal = FactoryGirl.create(:goal, subject: @subject)
    @goal.should be_valid
  end
  
  describe "validations" do
    
    it "should have a subject_id" do
      Goal.new(@goal_attr).should_not be_valid
    end
    
    it "should have a goal" do
      Goal.create(goal: "").should_not be_valid
    end
    
  end
  
  describe "Subject associations" do
    
    it "should have a subject attribute" do
      @goal.should respond_to(:subject)
    end
    
    it "should have the right associated subject" do
      @goal.subject_id.should == @subject.id
      @goal.subject.should == @subject
    end 
    
  end
  
end
