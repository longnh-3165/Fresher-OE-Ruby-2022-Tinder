FactoryBot.define do
  factory :user do
    name{Faker::Name.name}
    date_of_birth{Faker::Date.birthday(min_age: 20, max_age: 49)}
    gender{Faker::Number.between(from: 0, to: 1)}
    email{Faker::Internet.email.upcase}
    facebook{"facebook"}
    country
    phone{"0905123123"}
    description{"A lonely clone looking for another lonely clone"}
    password{"123456"}
  end
end
