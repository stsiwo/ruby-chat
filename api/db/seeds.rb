# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nanoid'
require 'faker'

admin = UserType.create(id: Nanoid.generate(size: 11), name: "ADMIN")
member = UserType.create(id: Nanoid.generate(size: 11), name: "MEMBER")

5.times do |i|
  User.create!(id: Nanoid.generate(size: 11), name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Name.name, user_type: member)
end