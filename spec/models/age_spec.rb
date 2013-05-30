# == Schema Information
#
# Table name: ages
#
#  id               :integer          not null, primary key
#  student_group_id :integer
#  age_group        :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Age do
  
  before(:each) do
    association_attr  
  end
  
  it "should create a new instance with valid attributes" do
    @student_group.create_age(@age_attr).should be_valid
  end
  
  describe "validations" do
    
    it "should have a student_group_id" do
      Age.new(@age_attr).should_not be_valid
    end
    
    it "should require a valid age group" do
      wrong_age_group = @student_group.create_age(@age_attr.merge(age_group: "OLD PEOPLE"))
      wrong_age_group.should_not be_valid
    end
    
  end

  describe "Student_group associations" do

    it "should have a Student_group attribute" do
      @age.should respond_to(:student_group)
    end

    it "should have the right associated user" do
      @age.student_group_id.should == @student_group.id
      @age.student_group.should == @student_group
    end

  end
  
end
