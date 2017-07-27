# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = 'supersecret'

Tag.destroy_all
Review.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

User.create first_name: 'Jon', last_name: 'Snow', email: 'js@winterfell.gov', password: PASSWORD

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

users = User.all

50.times do
  tag = Tag.create(name: Faker::Book.genre)
end

tags = Tag.all

220.times do
  category = Category.all.sample
  user = User.all.sample

  p = Product.create(
    title: Faker::Book.title,
    description: Faker::TwinPeaks.quote,
    price: Faker::Commerce.price,
    category_id: category.id,
    user_id: (User.all.sample).id
  )

  p.tags = tags.shuffle.slice(1..rand(7))
end

products = Product.all
products.each do |p|
  rand(1..4).times do
    r = Review.create(
      body: Faker::FamilyGuy.quote,
      rating: rand(1..5),
      product_id: p.id,
      user_id: (User.all.sample).id
    )
    r.likers = users.shuffle.slice(0..rand(users.count))
  end
end



puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say("Created #{products.count} products", :cow)
puts Cowsay.say("Created #{tags.count} tags", :stimpy)
puts Cowsay.say("Created #{Like.count} likes", :sheep)
puts Cowsay.say("Created #{Review.count} answers", :ghostbusters)
