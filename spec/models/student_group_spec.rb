# == Schema Information
#
# Table name: student_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subject    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe StudentGroup do

  before(:each) do
    @attr = {
      name: "class_name", 
      subject: "subject 101"
    }
  end

  it "should create a new instance given a valid attribute" do
    StudentGroup.create!(@attr).should be_valid
  end

  # name

  it "should require a name" do
     no_name_student_group = StudentGroup.new(@attr.merge(name: ""))
     no_name_student_group.should_not be_valid
   end

   it "should require a name between 3 and 40 characters" do
     long_name = "a" * 41
     short_name = "a" * 2

     wrong_namelength_student_group = StudentGroup.new(@attr.merge(name: long_name) || StudentGroup.new(@attr.merge(name: short_name)))
     wrong_namelength_student_group.should_not be_valid
   end
   
  # subject
  
  it "should require a subject" do
     no_subject_student_group = StudentGroup.new(@attr.merge(subject: ""))
     no_subject_student_group.should_not be_valid
   end

   it "should require a subject between 3 and 40 characters" do
     long_name = "a" * 41
     short_name = "a" * 2

     wrong_subject_length_student_group = StudentGroup.new(@attr.merge(subject: long_name) || StudentGroup.new(@attr.merge(subject: short_name)))
     wrong_subject_length_student_group.should_not be_valid
   end 

end
