FactoryGirl.define do
  sequence(:email) { |n| "peter#{n}@pan.com" }  
  factory :user do
    email 
    password "1234567890"
    first_name "Peter"
    last_name "Example"
    admin false
  end
  factory : admin, class User do
    email 
    password "1234567890"
    first_name "Peter"
    last_name "Example"
    admin true
  end
end