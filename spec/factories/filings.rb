FactoryBot.define do
  factory :filing do
    amended_return  { false }
    association     :filer
    return_timestamp { DateTime.parse('2022-04-15') }
    tax_period       { Faker::Date.backward(days: 365).end_of_year }
  end
end
