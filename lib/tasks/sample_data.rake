require 'faker'

namespace :db do
  
  desc "Fill db with sample data"
  
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(name:                  "Example User",
                         email:                 "example@email.com",
                         password:              "password",
                         password_confirmation: "password")
    admin.toggle!(:admin)                     
    99.times do |n|
      name = Faker::Name.name
      email = "example_#{n+1}@example.com"
      password = "password"
      User.create!(name:                  name,
                   email:                 email,
                   password:              password,
                   password_confirmation: password) 
    end
                 
  end
  
end