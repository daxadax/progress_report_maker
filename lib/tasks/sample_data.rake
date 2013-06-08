require 'faker'

namespace :db do
  
  desc "Fill db with sample data"
  
  task populate: :environment do
    require 'populator'
  
    Rake::Task['db:reset'].invoke
    User.populate 100 do |user|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      user.name = first_name + " " + last_name
      user.email = "#{first_name+last_name}@example.com"
      user.encrypted_password = "password"
      user.salt = "#{Time.now.utc}--#{user.encrypted_password}" 
      StudentGroup.populate 2..5 do |group| 
        group.user_id = user.id
        group.name = Populator.words(1..3)
        group.created_at = 2.years.ago..Time.now
      end
    end 
  end
end
