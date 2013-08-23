namespace :db do

  desc "Fill db with sample data"

  task :populate, :environment do

    # warning message
    puts "##############################################################"
    puts "# if this takes too long, reduce the number of created users #"
    puts "##############################################################"
    
    # reset the database
    reset_db

    # some messages
    puts "Database reset. Database population started"
    
    # create users
    create_users

    #create student_groups for each user  
    create_student_groups
    
    #create students for each student_group
    create_students
    
    #create subjects for each student_group
    create_subjects
    
    #create goals for each subject
    create_goals
    
    #create evaluation data for each goal
    create_evaluations
    
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
    # change the number of users here
    FactoryGirl.create_list :user, 1
    puts "--- Created #{User.all.count} user(s)"
  end
  
  def create_student_groups
    puts "Creating student groups for each user"
    User.all.each do |u|
      FactoryGirl.create_list :student_group, 3, user_id: u.id
    end
    puts "--- Created #{StudentGroup.all.count} groups"
  end
  
  def create_students
    puts "Creating students for each student group"
    StudentGroup.all.each do |sg|
      FactoryGirl.create_list :student, 7, student_group_id: sg.id
    end
    puts "--- Created #{Student.all.count} students"
  end
  
  def create_subjects
    puts "Creating subjects for each student group"
    StudentGroup.all.each do |sg|
      FactoryGirl.create_list :subject, 3, student_group_id: sg.id
    end
    puts "--- Created #{Subject.all.count} subjects"
  end  
  
  def create_goals
    puts "Creating goals for each subject"
    Subject.all.each do |s|
      FactoryGirl.create_list :goal, 3, subject_id: s.id
    end
    puts "--- Created #{Goal.all.count} goals"
  end  

  def create_evaluations
    @students = Student.all
    @goals = Goal.all
    puts "Creating evaluation data for #{@students.count} students and #{@goals.count} goals"
    @students.each_with_index do |s, index|
      @goals.count.times do |i|
        FactoryGirl.create_list :evaluation, 3, goal_id: @goals[i].id, student_id: s.id
      end
    # counter to track progress
    puts "Created data for 'Student #{index +1}'"  
    end
  end

end
