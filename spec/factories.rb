require 'faker'

FactoryGirl.define do
  
  factory :user do
    sequence(:name) { |n| "User #{n}"}
    sequence(:email) { |n| "user#{n}@example.com"}
    password "password"
  end

  factory :student_group do |student_group|
    sequence(:name) {|n| "class #{n}"}
    student_group.type_of_group { ["young learners class (0-6)", "primary class (7-12)", "secondary class (13-17)", "adult class (18+)", "children's sport team", "adult's sport team"].sample }
    student_group.association :user
  end

  factory :student do |student|
    sequence(:name) { |n| "student #{n}" }
    student.gender { %w[Male Female Transgender].sample }
    student.association :student_group
  end

  factory :subject do |subject|
    subject.name { %w[Math Science Basket_Weaving Necromancy Potions Welding Alchemy Brainwashing War_Making Love_Making].sample }
    subject.end_date Date.today+180
    subject.association :student
  end  

  factory :characteristic do |characteristic|
    # http://stackoverflow.com/questions/8223059/what-is-the-proper-way-to-select-an-item-randomly-from-an-array-when-writing-fac
    characteristic.characteristic { %w[Autistic Dyslexic Violent Auditory_Dominant Young Blind Hearing_Impaired Visual_Dominant Kinesthetic_Dominant ADHD Gifted].sample }
    characteristic.association :student
  end

  factory :goal do |goal|
    goal.goal { ["Participate in class", "Respect others", "Spell common words correctly", "Drink 1 gallon of milk in under a minute without vomiting", "Stand for three rounds with Ali", "Make you smile", "Replace my soul with acid"].sample }
    goal.association :subject
  end

end  
  