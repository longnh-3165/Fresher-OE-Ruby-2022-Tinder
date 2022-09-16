Country.create!(
  name: "Hà Nội"
)
Country.create!(
  name: "Đà Nẵng"
)
Country.create!(
  name: "Hồ Chí Minh"
)
User.create!(name: "hoanglong",
  date_of_birth: Faker::Date.birthday,
  gender: 0,
  email: "hoanglong@gmail.com",
  facebook: "hoanglong",
  phone: "0932123123",
  description: "hello world",
  password: "123456",
  actived: true,
  admin: true,
  type_of: 1,
  country_id: 2)
20.times do |n|
name = Faker::Name.name
date_of_birth = Faker::Date.birthday
email = Faker::Internet.email
facebook = Faker::Twitter.screen_name
phone = Faker::PhoneNumber.cell_phone
description = Faker::String.random
password = "123456"
User.create!(name: name,
  date_of_birth: date_of_birth,
  gender: 0,
  email: email,
  phone: phone,
  facebook: facebook,
  description: description,
  password: password,
  actived: true,
  type_of: 0,
  country_id: 3)
end
