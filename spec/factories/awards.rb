FactoryBot.define do
  factory :grant_award do
    amount         { 100.0 }
    association    :filing
    association    :recipient
  end
end
