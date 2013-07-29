require 'factory_girl_rails'

namespace :db do

  desc "Fill db with sample data"

  task :populate, :environment do

    # reset the database
    reset_db

    # create 100 users
    create_users

    #create 3 student_groups for each user  
    create_student_groups
    
    #create students for each student_group
    create_students
    
    #create subjects for each student_group
    create_subjects
    
    #create goals for each subject
    create_goals
    
    # success message
    puts "The database has been populated successfully"
  
  end

###################
####  METHODS  ####
###################

  def reset_db
    puts "Resetting the database"
    Rake::Task['db:reset'].invoke
  end

  def create_users
    puts "Creating users"
    FactoryGirl.create_list :user, 100
  end
  
  def create_student_groups
    puts "Creating student groups for each user"
    User.all.each do |u|
      FactoryGirl.create_list :student_group, 3, user_id: u.id
    end
  end
  
  def create_students
    puts "Creating students for each student group"
    StudentGroup.all.each do |sg|
      FactoryGirl.create_list :student, 7, student_group_id: sg.id
    end
  end
  
  def create_subjects
    puts "Creating subjects for each student group"
    StudentGroup.all.each do |sg|
      FactoryGirl.create_list :subject, 4, student_group_id: sg.id
    end
  end  
  
  def create_goals
    puts "Create goals for each subject"
    Subject.all.each do |s|
      FactoryGirl.create_list :goal, 3, subject_id: s.id
    end
  end
  
end
