# == Schema Information
#
# Table name: characteristics
#
#  id             :integer          not null, primary key
#  characteristic :string(255)
#  student_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Characteristic do
  
  before(:each) do
    association_attr
  end

  it "should create a new instance with valid attributes" do
    @student.characteristics.new(@char_attr).should be_valid
  end

  describe "Student associations" do

    it "should have a student attribute" do
      @characteristic.should respond_to(:student)
    end

    it "should have the right associated student" do
      @characteristic.student_id.should == @student.id
      @characteristic.student.should == @student
    end

  end
  
end
