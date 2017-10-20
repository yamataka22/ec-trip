FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "カテゴリー#{n}"}
    sequence(:sequence) {|n| n}
  end
end
