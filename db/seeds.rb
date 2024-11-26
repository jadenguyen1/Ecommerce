# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'
require 'faker'

# Clear existing data
Genre.delete_all
Province.delete_all
Author.delete_all
Book.delete_all

# Load genres from CSV
CSV.foreach(Rails.root.join('db/genres.csv'), headers: true) do |row|
  Genre.create!(name: row['name'])
end

# Load provinces from CSV
CSV.foreach(Rails.root.join('db/provinces.csv'), headers: true) do |row|
  Province.create!(name: row['name'])
end


# Load authors from CSV
CSV.foreach(Rails.root.join('db/authors.csv'), headers: true) do |row|
  Author.create!(name: row['name'])
end

# Generate books with random authors, genres, and data
100.times do
  Book.create!(
    title: Faker::Book.title,
    description: "",
    stock: rand(1..10),
    sale: [true, false].sample,
    price: Faker::Commerce.price(range: 2.00..30.00),
    author: Author.order("RANDOM()").first,
    genre: Genre.order("RANDOM()").first
  )
endAdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?