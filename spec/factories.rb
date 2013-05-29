FactoryGirl.define do
  factory :user do |user|
    user.name                   "user"
    user.email                  "user@example.com"
    user.password               "password"
    user.password_confirmation  "password"
  end
  
  factory :student_group do |student_group|
    student_group.name "class 1"
    student_group.association :user
  end
  
  factory :student do |student|
    student.name   "Tim Learningman"
    student.gender "Male"
    student.association :student_group
  end
  
  factory :characteristic do |characteristic|
    characteristic.characteristic "Autistic"
    characteristic.association :student
  end
  
  factory :goal do |goal|
    goal.goal "To unlearn the evil"
    goal.association :subject
  end
  
end  