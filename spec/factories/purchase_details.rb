FactoryGirl.define do
  factory :purchase_detail do
    purchase nil
    item nil
    item_name "MyString"
    price 1
    quantity 1
  end
end
