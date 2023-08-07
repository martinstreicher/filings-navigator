FactoryBot.define do
  factory :award do
    amended_return { false }
    amount         { 100.0 }
    association    :filing
    association    :recipient
  end
end
