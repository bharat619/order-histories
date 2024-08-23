# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
include Utils

20.times do
  Post.create(
    title: Faker::Lorem.sentence(word_count: 1),
    body: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

USER_CSV_PATH = Rails.root.join('data', 'users.csv')
PRODUCTS_CSV_PATH = Rails.root.join('data', 'products.csv')
ORDER_DETAILS_CSV_PATH = Rails.root.join('order_details.csv')

users = CSV.read(USER_CSV_PATH)[1..]
users.each do |user|
  User.create!(username: user[0], email: user[1], phone: user[2])
rescue ActiveRecord::RecordInvalid => e
  log(e.message)
end
