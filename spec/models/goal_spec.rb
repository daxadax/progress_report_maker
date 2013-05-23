# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  goal       :string(255)
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Goal do
  
  before(:each) do
    association_attr  
  end
  
  it "should create a new instance with valid attributes" do
    @subject.goals.create!(@goal_attr).should be_valid
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
