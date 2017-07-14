# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all



categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']

categories.each do |category|
  Category.create(name: category)
end

20.times do
  user = Faker::GameOfThrones.character
  email = user.delete(' ').downcase
  names = user.split(' ')
  User.create(
    email: "#{email}@cohort19.com",
    first_name: names.first,
    last_name: names.last,
    password: '12345',
    password_confirmation: '12345'
  )
end


200.times do
  category = Category.all.sample
  user = User.all.sample

  p = Product.create(
    title: Faker::Book.title,
    description: Faker::Hipster.sentence,
    price: Faker::Commerce.price,
    category_id: category.id,
    user_id: (User.all.sample).id
  )
end

products = Product.all
products.each do |p|
  rand(0..9).times do
    Review.create(
      body: Faker::FamilyGuy.quote,
      rating: rand(1..5),
      product_id: p.id,
      user_id: (User.all.sample).id
    )
  end
end



puts "#{Product.count} products created!"
