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

require 'spec_helper'

describe StudentGroup do

  before(:each) do
    association_attr  
  end

  it "should create a new instance with valid attributes" do
    @user.student_groups.create!(@attr).should be_valid
  end

  describe "User associations" do

    it "should have a user attribute" do
      @student_group.should respond_to(:user)
    end

    it "should have the right associated user" do
      @student_group.user_id.should == @user.id
      @student_group.user.should == @user
    end

  end

  describe "Student associations" do

    it "should have a student attribute" do
      @student_group.should respond_to(:students)
    end

    it "should destroy associated students" do
      @student_group.destroy
      [@student, @student2].each do |student|
        Student.find_by_id(student.id).should be_nil
      end
    end

  end
  
  describe "Age associations" do
    
    it "should have an age attribute" do
      @student_group.should respond_to(:age)
    end
    
    it "should destroy associated age" do
      @student_group.destroy
      Age.find_by_id(@age).should be_nil
    end
    
  end

end
