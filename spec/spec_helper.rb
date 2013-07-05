# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  
  def test_login(user)
    controller.login(user)
  end
  
  def association_attr
    # User attritbutes 
    @user = Factory(:user)
  
    # Student_group
    @student_group = Factory(:student_group, user: @user)
    @student_group2 = Factory(:student_group, user: @user, name: "Rainbow class")
      
    # Student attributes
    @student_attr = { gender: "Female", name: "Example Student" }
    # Student 
    @student = @student_group.students.new(@student_attr)
    @student.save
    @student2 = Factory(:student, student_group: @student_group)
  
    # Subject attributes
    @subject_attr = { name: "English", end_date: @date }
    @date = Date.today+180
    # Subject
    @subject = @student.subjects.new(@subject_attr)
    @subject.save
    
    # Goal
    @goal = Factory(:goal, subject: @subject)
    @goal2 = Factory(:goal, subject: @subject, goal: "Should display appropriate classroom behavior")
    
    # Characteristic
    @characteristic =  Factory(:characteristic, student: @student)
    @characteristic2 = Factory(:characteristic, student: @student, characteristic: "Dyslexic")
    
    # Age attributes
    @age_attr = { age_group: "Adults (16+)"}
    # Age_group
    # For has_one associations use 'create_object'
    # http://stackoverflow.com/questions/7479083/ruby-on-rails-3-has-one-association-testing
    @age = @student_group.create_age(@age_attr)
    
  end
  
end
