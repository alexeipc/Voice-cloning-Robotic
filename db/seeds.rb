# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create admin user
User.create!(
    email: 'Admin'
    password: 'Password',
    is_admin: true
)

User.create!(
    email: 'User'
    password: 'Password',
    is_admin: false
)

10.times do |i|
    dashboard.create!(make: 'Rails Auto', model: "New dashboard #{i}", year: "200#{i}")
  end