FactoryGirl.define do
  factory :address do
    member nil
    invoice false
    main false
    last_name "MyString"
    first_name "MyString"
    postal_code "MyString"
    prefecture_id 1
    address1 "MyString"
    address2 "MyString"
    phone "MyString"
  end
end
