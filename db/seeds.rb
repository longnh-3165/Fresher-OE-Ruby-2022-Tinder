Country.create!(name: "Hanoi")
Country.create!(name: "HCM City")
Country.create!(name: "Danang")
User.create!(name: "hoang long",
             date_of_birth: "1998-01-20",
             gender: 0,
             email: "hoanglong@gmail.com",
             facebook: "hoanglong",
             phone: "0932123123",
             description: "hello world",
             password: "123456",
             actived: true,
             admin: true,
             type_of: 1,
             country_id: 3)
20.times do
  name = Faker::Name.name
  date_of_birth = Faker::Date.birthday(min_age: 20, max_age: 49)
  gender = Faker::Number.between(from: 0, to: 1)
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.cell_phone
  description = "A lonely clone looking for another lonely clone"
  password = "123456"
  country_id = Faker::Number.between(from: 1, to: 3)
  type_of = Faker::Number.between(from: 0, to: 1)
  User.create!(name: name,
               date_of_birth: date_of_birth,
               gender: gender,
               email: email,
               phone: phone,
               description: description,
               password: password,
               actived: true,
               type_of: type_of,
               country_id: country_id)
end
users = User.order(:created_at).take(6)
20.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each {|user| user.messages.create!(content: content)}
end
