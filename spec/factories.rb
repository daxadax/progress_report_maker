FactoryGirl.define do
  factory :user do |user|
    user.name                   "user"
    user.email                  "user@example.com"
    user.password               "password"
    user.password_confirmation  "password"
  end
end  