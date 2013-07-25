# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  gender           :string(255)
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

  describe "validations" do
    
    it "should have a student_group_id" do
      Student.new(@student_attr).should_not be_valid
    end

    it "should require a valid gender" do
      wrong_gender_student = @student_group.students.new(@student_attr.merge(gender: "Zlorp"))
      wrong_gender_student.should_not be_valid
    end
    
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

  describe "Characteristic associations" do
    
    it "should have a characteristic attribute" do
      @student.should respond_to(:characteristics)
    end
    
    it "should destroy associated characteristics" do
      @student.destroy
      [@characteristic, @characteristic2].each do |characteristic|
        Characteristic.find_by_id(characteristic.id).should be_nil
      end
    end    
    
  end

end
