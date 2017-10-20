FactoryGirl.define do
  factory :item do
    name 'Item Name'
    description 'Item Description'
    about 'Item About'
    price 1000
    stock_quantity 10
    remarks 'Item Remarks'
  end
end
