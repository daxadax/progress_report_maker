# == Schema Information
#
# Table name: subjects
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  end_date         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_group_id :integer
#  start_date       :string(255)
#  contact_time     :integer
#

require 'spec_helper'
include ApplicationHelper

describe Subject do
  
  before(:each) do
    association_attr  
  end
  
  it "should create a new instance with valid attributes" do
    @student_group.subjects.new(@subject_attr).should be_valid
  end
  
  describe "validations" do
    
    it "should have a student_group_id" do
      Subject.new(@subject_attr).should_not be_valid
    end
    
    it "should have a name" do
      no_name_subject = @student_group.subjects.new(@subject_attr.merge(name: ""))
      no_name_subject.should_not be_valid
    end
    
    it "should have a start date" do
      no_start_date = @student_group.subjects.new(@subject_attr.merge(start_date: ""))
      no_start_date.should_not be_valid
    end
    
    it "should have an end date" do
      no_end_date = @student_group.subjects.new(@subject_attr.merge(end_date: ""))
      no_end_date.should_not be_valid
    end
    
    it "should have an end date that is later than the start date" # do
    #       
    #     end
    
    describe "contact time" do
      
      it "should exist" do
        no_contact_time = @student_group.subjects.new(@subject_attr.merge(contact_time: ""))
        no_contact_time.should_not be_valid
      end

      it "should be an integer" do
        non_numerical_contact_time = @student_group.subjects.new(@subject_attr.merge(contact_time: "string"))
        non_numerical_contact_time.should_not be_valid
      end

    end
    
  end
  
  describe "methods" do
    
    describe "weeks_left" do
      
      it "should have the right methods" do
        @subject.should respond_to(:weeks_left)
        @subject.should respond_to(:weeks_status)
      end
      
      it "should return appropriate data" do
        completed = FactoryGirl.create(:subject,          student_group: @student_group, 
                                                          end_date:      Date.today-10 )
        less_than_one_week = FactoryGirl.create(:subject, student_group: @student_group, 
                                                          end_date:      Date.today+1 )
        one_week = FactoryGirl.create(:subject,           student_group: @student_group, 
                                                          end_date:      Date.today+7 )
        lots_of_time = FactoryGirl.create(:subject,       student_group: @student_group, 
                                                          end_date:      Date.today+180 )
                                            
        completed.weeks_left.should eq "completed"
        completed.weeks_status.should eq :complete
        
        less_than_one_week.weeks_left.should eq "less than 1 week"
        less_than_one_week.weeks_status.should eq :struggle
        
        one_week.weeks_left.should eq "1 week"
        one_week.weeks_status.should eq :meet
        
        lots_of_time.weeks_left.should eq "25 weeks"
        lots_of_time.weeks_status.should eq ""                                                                  
      end
      
    end
    
    describe "completed" do
      
      it "should respond to `completed`" do
        @subject.should respond_to(:completed)                                                        
      end

      it "should return complete subjects" do
        completed = FactoryGirl.create(:subject,          student_group: @student_group, 
                                                          end_date:      Date.today-10 )
        @student_group.subjects.completed.should include(completed)
      end
      
    end
    
    describe "averages" do
          
      it "should calculate the average correctly with 'avg'" do
        goal_subject = FactoryGirl.create(:subject, student_group: @student_group)
        g1 = FactoryGirl.create(:goal, subject: goal_subject, goal: "goal 1")
          g1e1 = FactoryGirl.create(:evaluation, goal: g1, student: @student, score: 3)
          g1e2 = FactoryGirl.create(:evaluation, goal: g1, student: @student, score: 4)
          g1e3 = FactoryGirl.create(:evaluation, goal: g1, student: @student, score: 4)
        g2 = FactoryGirl.create(:goal, subject: goal_subject, goal: "goal 2")
          g2e1 = FactoryGirl.create(:evaluation, goal: g2, student: @student, score: 3)
          g2e2 = FactoryGirl.create(:evaluation, goal: g2, student: @student, score: 5)
          g2e3 = FactoryGirl.create(:evaluation, goal: g2, student: @student, score: 1)
          
        goal_subject.avg.should eq 3.33
      end
      
      it "should return the right status/avg_to_words using avg_for(student)" do
        struggling_student = FactoryGirl.create(:student, student_group: @student_group)
          ss_e1 = FactoryGirl.create(:evaluation, student: struggling_student,
                                                  goal: @goal,
                                                  score: 3)
          ss_e2 = FactoryGirl.create(:evaluation, student: struggling_student,
                                                  goal: @goal,
                                                  score: 2)
          ss_e3 = FactoryGirl.create(:evaluation, student: struggling_student,
                                                  goal: @goal,
                                                  score: 2)
        good_student = FactoryGirl.create(:student, student_group: @student_group)
          gs_e1 = FactoryGirl.create(:evaluation, student: good_student,
                                                  goal: @goal,
                                                  score: 4)
          gs_e2 = FactoryGirl.create(:evaluation, student: good_student,
                                                  goal: @goal,
                                                  score: 3)
          gs_e3 = FactoryGirl.create(:evaluation, student: good_student,
                                                  goal: @goal,
                                                  score: 3)   
        amazing_student = FactoryGirl.create(:student, student_group: @student_group)
          as_e1 = FactoryGirl.create(:evaluation, student: amazing_student,
                                                  goal: @goal,
                                                  score: 4)
          as_e2 = FactoryGirl.create(:evaluation, student: amazing_student,
                                                  goal: @goal,
                                                  score: 4)
          as_e3 = FactoryGirl.create(:evaluation, student: amazing_student,
                                                  goal: @goal,
                                                  score: 4)                                     
                                                  
        # struggling student
        status(struggling_student.avg).should eq :struggle
        avg_to_words(struggling_student.avg).should eq "Struggling"
        # good student
        status(good_student.avg).should eq :meet
        avg_to_words(good_student.avg).should eq "Meets expectations"
        # amazing student
        status(amazing_student.avg).should eq :exceed
        avg_to_words(amazing_student.avg).should eq "Exceeds expectations"
      end
                
    end
    
    describe "eval_count" do
      
      it "should return the correct number of evaluations" do
        goal_subject = FactoryGirl.create(:subject, student_group: @student_group)
        g1 = FactoryGirl.create(:goal, subject: goal_subject, goal: "goal 1")
          g1e1 = FactoryGirl.create(:evaluation, goal: g1, student: @student, eval_number: 1)
          g1e2 = FactoryGirl.create(:evaluation, goal: g1, student: @student, eval_number: 2)
          g1e3 = FactoryGirl.create(:evaluation, goal: g1, student: @student, eval_number: 3)
          
        puts goal_subject.evals
        goal_subject.eval_count.should eq 3 
      end
      
    end
    
  end
  
  describe "Student_Group associations" do
    
    it "should have a student_group attribute" do
      @subject.should respond_to(:student_group)
    end
    
    it "should have the right associated student_group" do
      @subject.student_group_id.should == @student_group.id
      @subject.student_group.should == @student_group
    end 
    
  end
  
  describe "Goal associations" do
    
    it "should have a goal attribute" do
      @subject.should respond_to(:goals)
    end
    
    it "should destroy associated goals" do
      @subject.destroy
      [@goal, @goal2].each do |goal|
        Goal.find_by_id(goal.id).should be_nil
      end
    end
    
  end
    
end
