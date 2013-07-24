# == Schema Information
#
# Table name: student_groups
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  number_of_students :integer
#  type_of_group      :string(255)
#

require 'spec_helper'

describe StudentGroup do

  before(:each) do
    association_attr  
  end

  it "should create a new instance with valid attributes" do
    @student_group.should be_valid
  end
  
  describe "validations" do
    
    it "should have a user_id" do
      StudentGroup.new(name: "class 3").should_not be_valid
    end
    
    it "should reject blank names" do
      StudentGroup.new(name: "").should_not be_valid
    end
    
    it "should reject too long names" do
      too_long_name = "a" * 26
      StudentGroup.new(name: too_long_name).should_not be_valid
    end
    
    it "should have a type" do
      StudentGroup.new(type_of_group: "").should_not be_valid
    end
    
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

end
