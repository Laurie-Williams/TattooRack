FactoryGirl.define do
  factory :piece do
    sequence(:title) { |n| "piece_#{n}"}
    description "example description"
    image {File.new("#{Rails.root}/app/assets/images/test.png")}
  end
end