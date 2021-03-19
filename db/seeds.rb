# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |a|
    User.create(
        email: Faker::Internet.email,
        password: '123456',
        username: Faker::Name.name
    )
end

10.times do |a|
    Friend.create(
        user_id: a,
        friend_id: rand(10)
    )
end


50.times do |a|
   Tweet.create(content: Faker::Lorem.words(number: 25).join(' '),
   user_id: rand(10)
) 
end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?