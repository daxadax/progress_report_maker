# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  gender     :string(255)
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Student do


  before(:each) do
    @attr = {
      name: "student", 
      gender: "queen"
    }
  end

  it "should create a new instance given a valid attribute" do
    Student.create!(@attr).should be_valid
  end

  # name

  it "should require a name" do
     no_name_student = Student.new(@attr.merge(name: ""))
     no_name_student.should_not be_valid
   end

   it "should require a name between 3 and 40 characters" do
     long_name = "a" * 41
     short_name = "a" * 2

     wrong_namelength_student = Student.new(@attr.merge(name: long_name) || Student.new(@attr.merge(name: short_name)))
     wrong_namelength_student.should_not be_valid
   end
   
   # gender
   
   it "should require a gender" do
     genderless_student = Student.new(@attr.merge(gender: ""))
     genderless_student.should_not be_valid
   end
  
end
