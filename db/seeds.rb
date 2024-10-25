# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: "a@b", password: "321654")

user_attributes = [
  { name: "中川", email: "nakagawa@test.com" },
  { name: "北川", email: "kitagawa@test.com" },
  { name: "植野", email: "ueno@test.com" },
  { name: "芳賀", email: "haga@test.com" },
  { name: "高橋", email: "takahashi@test.com" }
]

user_attributes.each do |attributes|
  User.create!(attributes.merge({ password: "123456" }))
end