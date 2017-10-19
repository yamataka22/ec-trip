FactoryGirl.define do
  factory :purchage do
    member nil
    credit_card nil
    stripe_charge_id "MyString"
    item_amount 1
    tax 1
    delivery_fee 1
    delivery_last_name "MyString"
    delivery_first_name "MyString"
    delivery_phone "MyString"
    delivery_postal_code "MyString"
    delivery_prefecture_id 1
    delivery_address1 "MyString"
    delivery_address2 "MyString"
    invoice_last_name "MyString"
    invoice_first_name "MyString"
    invoice_phone "MyString"
    invoice_postal_code "MyString"
    invoice_prefecture_id 1
    invoice_address1 "MyString"
    invoice_address2 "MyString"
  end
end
