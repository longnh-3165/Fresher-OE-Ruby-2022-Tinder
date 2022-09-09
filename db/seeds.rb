User.create!(name: "hoanglong",
  date_of_birth: "1998-20-01",
  gender: 0,
  email: "hoanglong@gmail.com",
  facebook: "hoanglong",
  phone: "0932123123",
  description: "hello world",
  password: "123456",
  actived: true,
  admin: true,
  type_of: 1)
20.times do |n|
name = Faker::Name.name
date_of_birth = Faker::Date.birthday
email = Faker::Internet.email
phone = Faker::PhoneNumber.cell_phone
description = "clone"
password = "123456"
User.create!(name: name,
  date_of_birth: date_of_birth,
  gender: 0,
  email: email,
  phone: phone,
  description: description,
  password: password,
  actived: true,
  type_of: 0)
end
