# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    post_id 1
    name "MyString"
    email "MyString"
    body "MyText"
  end
end
