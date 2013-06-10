require 'factory_girl_rails'

namespace :db do

  desc "Fill db with sample data"

  task :populate, :environment do

    # reset the database
    puts "Resetting the database"
    Rake::Task['db:reset'].invoke

    # create 100 users
    puts "Creating users"
    new_users = FactoryGirl.create_list :user, 100

    #create 3 student_groups for each user  
    puts "Creating student groups for each user"
    new_users.each do |u|
      FactoryGirl.create_list :student_group, 3, :user_id => u.id
    end

    # success message
    puts "The database has been populated successfully"
  end
end