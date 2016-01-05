# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "test@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

24.times do |n|
  content = Faker::Hipster.paragraphs(6).join("<br /> <br />")
  location = Faker::Address.city
  rating = Faker::Number.between(1, 10)
  created_at = Time.now - (n+1)*86400
  Entry.create!(content: content,
                location: location,
                rating: rating,
                created_at: created_at,
                user_id: 1)
end