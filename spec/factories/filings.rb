FactoryBot.define do
  factory :filing do
    association :filer
    filed_at    { DateTime.parse('2022-04-15') }
    tax_period  { Faker::Date.backward(days: 365).end_of_year }
  end
end
