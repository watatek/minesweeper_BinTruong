FactoryBot.define do
  factory :board do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    width { 10 }
    height { 10 }
    mines { 10 }
  end
end