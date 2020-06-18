# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Add Users

require 'faker'

puts "cleaning db...."

  Book.destroy_all
  User.destroy_all

puts "Done !"

users = [
  {email: 'max@lewagon.org', first_name: 'Maxime', last_name: 'Berthelot', address: Faker::Address.full_address, password: 'maxime'},
  {email: 'pauline@lewagon.org', first_name: 'Pauline', last_name: 'Paris', address: Faker::Address.full_address, password: 'pauline'},
  {email: 'clement@lewagon.org', first_name: 'Clément', last_name: 'Lemaire', address: Faker::Address.full_address, password: 'clement'},
  {email: 'alex@lewagon.org', first_name: 'Alex', last_name: 'Platteeuw', address: Faker::Address.full_address, password: 'alexandre'},
  {email: 'barth@lewagon.org', first_name: 'Barthélémy', last_name: 'Boillot', address: Faker::Address.full_address, password: 'barthelemy'}
]

i = 0

while i < users.size do
  puts "creating user ##{i + 1} ... "
  # initialize and save book in the db
  user = User.create!(users[i])
  i += 1
  # render user details in the console
  puts "____________________________________________________________
        email: #{user.email}
        password: #{user.password}
        first name: #{user.first_name}
        last name: #{user.last_name}
        address: #{user.address}"

  puts "____________________________________________________________"
end

#Add Books with Google Books API

#First let's define a list of ISBN codes

isbn = %w(
          9781781101032
          9781781101049
          9781781101056
          9781781101063
          9781781101070
          9781781101087
          9781781101094
          2226332197
          2226431438
          2226425675
          2714449867
          2714449948
          2714452035
          2742798234
          2742798242
          2742798250
          2330054637
          2330087349
          2330129025
          2210767474
          2814553437
          2253089354
          2322118397
          1524763136)

i = 0

while i < isbn.size

  puts "Fetching book ##{i + 1} data..."

  url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn[i]}"
  i += 1

  # json parsing

  book = open(url).read
  hash_book = JSON.parse(book)
  title = hash_book['items'].first['volumeInfo']['title'] || "undefined"
  author = hash_book['items'].first['volumeInfo']['authors'].first.split.map {|word| word.capitalize}.join(" ") || "undefined"
  description = hash_book['items'].first['volumeInfo']['description'] || "undefined"
  rating = hash_book['items'].first['volumeInfo']['averageRating'] || [3, 3.5, 4, 4.5, 5].sample
  rating =  rating.to_i if rating.class == String
  category = hash_book['items'].first['volumeInfo']['categories'].first || "undefined"
  address = Faker::Address.full_address

  book = Book.new(
    title: title,
    author: author,
    description: description,
    rating: rating,
    category: category,
    lender: User.all.sample,
    address: address
    )
  book.save!

  # render book details in the console

  puts "____________________________________________________________
        title: #{title}
        author: #{author}
        description: #{description}
        rating: #{rating}
        category: #{category}
        lender: #{book.lender.email}
        address: #{book.address}"
  puts "____________________________________________________________"
end

