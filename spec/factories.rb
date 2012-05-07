FactoryGirl.define do
  factory :person do
    name     "Stephen Doxsee"
    age    32
    status  'unsubscribed'
    parent_id nil
  end
end