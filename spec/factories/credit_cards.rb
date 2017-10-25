FactoryGirl.define do
  factory :credit_card do
    member nil
    stripe_card_id "MyString"
    brand "MyString"
    last4 "MyString"
    exp_month "MyString"
    exp_year "MyString"
    name "MyString"
    main false
  end
end
