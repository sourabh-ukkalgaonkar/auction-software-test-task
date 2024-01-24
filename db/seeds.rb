# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


password = "Test@123"

# Created a deault user 
User.create(
  name: 'tester',
  username: 'tester',
  email: 'tester@yopmail.com',
  password: password
)

# Created a list of users
(0..10).each do
  User.create(
    name: Faker::Name.name,
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: password,
  )
end

# Created a list of categories
(0..10).each do 
  Category.create(
    name: Faker::Commerce.department
  )
end

# Created a list of projects

users = User.all
categories = Category.all

(0..10).each do 
  Project.create(
    title: Faker::Book.title,
    user_id: users.sample.id,
    category_id: categories.sample.id
  )
end