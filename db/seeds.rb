# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require "faker"

# Product.destroy_all

# puts "Creating 676 products..."

# 676.times do
#   Product.create!(
#     title: Faker::Commerce.unique.product_name,
#     price: Faker::Commerce.price(range: 0..100.0, as_string: false),
#     stock_quantity: Faker::Number.between(from: 0, to: 1000)
#   )
# end

# puts "Created #{Product.count} products."

require "csv"

Product.destroy_all
Category.destroy_all

csv_file = Rails.root.join("db", "products.csv")

CSV.foreach(csv_file, headers: true) do |row|
  category_name = row["category"]
  category = Category.find_or_create_by(name: category_name)

  Product.create!(
    title: row["name"],
    description: row["description"],
    price: row["price"].to_f,
    stock_quantity: row["stock quantity"].to_i,
    category: category
  )
end

puts "Created #{Product.count} products in #{Category.count} categories."
