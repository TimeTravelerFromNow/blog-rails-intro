# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Blog.destroy_all


Blog.create!([
  {
  title: "Rails Developers Unite",
  description: "latest development blog",
  address: "rails-dev-blog"
  },
  {
  title: "Gaming",
  description: "my journey playing all sorts of games",
  address: "gaming-blog"
  },
  {
  title: "Travel Blog",
  description: "Very first travel blog",
  address: "travel-blog"
  }
])

# Add images as active storage file attachments
b0 = Blog.find_by(address: 'rails-dev-blog')
f0 = File.open( Rails.root.join('db/images/rails-development-window.jpg') )
b0.header_image.attach(io: f0, filename: 'rails-development-window.jpg')

b1 = Blog.find_by(address: 'gaming-blog')
f1 = File.open(  Rails.root.join('db/images/videogame-controller.jpg') )
b1.header_image.attach(io: f1, filename: 'videogame-controller.jpg')

b2 = Blog.find_by(address: 'travel-blog')
f2 = File.open( Rails.root.join('db/images/arizona-flag.jpg') )
b2.header_image.attach(io: f2, filename: 'arizona-flag.jpg')


