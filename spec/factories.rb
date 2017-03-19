FactoryGirl.define do 
  factory :user do 
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    first_name "Tom"
    last_name "Jones"
    password "secretPassword"
    password_confirmation "secretPassword"
  end
end
