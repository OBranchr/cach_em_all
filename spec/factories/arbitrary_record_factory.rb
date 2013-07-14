FactoryGirl.define do
  factory :arbitrary_record do
    sequence(:name) {|n| "Name#{n}"}
  end
end