require 'faker'

FactoryGirl.define do
  
  factory :user do
    sequence(:name) { |n| "User #{n}"}
    sequence(:email) { |n| "user#{n}@example.com"}
    password "password"
  end

  factory :student_group do |student_group|
    sequence(:name) {|n| "class #{n}"}
    student_group.type_of_group { ["Young learners class (0-6)", "Primary class (7-12)", "Secondary class (13-17)", "Adult class (18+)", "Children's sport team", "Adult's sport team"].sample }
    student_group.association :user
  end  
  
  factory :student do |student|
    student.name { Faker::Name.name }
    student.gender { %w[Male Female Transgender].sample }
    student.association :student_group
  end

  factory :subject do |subject|
    subject.name { %w[Math Science Basket_Weaving Necromancy Potions Welding Alchemy Brainwashing War_Making Love_Making].sample }
    subject.start_date Date.today+120
    subject.end_date Date.today+180
    subject.contact_time {[5, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100, 200].sample}
    subject.association :student_group
  end  

  factory :characteristic do |characteristic|
    # http://stackoverflow.com/questions/8223059/what-is-the-proper-way-to-select-an-item-randomly-from-an-array-when-writing-fac
    characteristic.characteristic { %w[Autistic Dyslexic Violent Auditory_Dominant Young Blind Hearing_Impaired Visual_Dominant Kinesthetic_Dominant ADHD Gifted].sample }
    characteristic.association :student
  end

  factory :goal do |goal|
    goal.goal { ["Participate in class", "Respect others", "Spell common words correctly", "Drink 1 gallon of milk in under a minute without vomiting", "Stand for three rounds with Ali", "Make you smile", "Replace my soul with chocolate pudding"].sample }
    goal.association :subject
  end

end