FactoryBot.define do
  factory :recipient do
    ein     { Faker::Company.ein }
    name    { Faker::Company.name}
    line1   { Faker::Address.street_address }
    city    { Faker::Address.city }
    state   { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
  end
end
