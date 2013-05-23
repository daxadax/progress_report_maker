# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  gender           :binary(3)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_group_id :integer
#

require 'spec_helper'

describe Student do

  before(:each) do
    association_attr
  end

  it "should create a new instance with valid attributes" do
    @student_group.students.create!(@student_attr).should be_valid
  end

  describe "Student_Group associations" do

    it "should have a student_group attribute" do
      @student.should respond_to(:student_group)
    end

    it "should have the right associated student_group" do
      @student.student_group_id.should == @student_group.id
      @student.student_group.should == @student_group
    end

  end

  describe "Subject associations" do

    it "should have a subject attribute" do
      @student.should respond_to(:subjects)
    end

  end

  describe "Characteristic associations" do
    
    it "should have a characteristic attribute" do
      @student.should respond_to(:characteristics)
    end
    
  end

end
