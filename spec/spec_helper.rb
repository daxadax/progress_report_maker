# simple_cov: https://github.com/colszowka/simplecov
require 'simplecov'
SimpleCov.start 'rails'

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
    @user = FactoryGirl.create(:user)
  
    # Student_group
    @student_group = FactoryGirl.create(:student_group, user: @user)
    @student_group2 = FactoryGirl.create(:student_group, user: @user, name: "Rainbow class")
    @student_groups = [@student_group, @student_group2]
      
    # Student attributes
    @student_attr = { gender: "Female", name: "Example Student" }
    # Student 
    @student = @student_group.students.new(@student_attr)
    @student.save
    @student2 = FactoryGirl.create(:student, student_group: @student_group)
  
    # Subject attributes
    @start_date = Date.today+120
    @end_date = Date.today+180
    
    @subject_attr = { name: "English", start_date: @start_date, end_date: @end_date, contact_time: 50 }
    # Subject
    @subject = @student_group.subjects.new(@subject_attr)
    @subject.save
    
    # Goal
    @goal = FactoryGirl.create(:goal, subject: @subject)
    @goal2 = FactoryGirl.create(:goal, subject: @subject, goal: "Should display appropriate classroom behavior")
    @goals = [@goal, @goal2]
    
    # Characteristic
    @characteristic =  FactoryGirl.create(:characteristic, student: @student)
    @characteristic2 = FactoryGirl.create(:characteristic, student: @student, characteristic: "Dyslexic")
    
    # Evaluation
    @eval = FactoryGirl.create(:evaluation, student: @student, goal: @goal)
    
  end
  
end
