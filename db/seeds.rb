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
  address: "dev-updates"
},
  {
  title: "Gaming",
  description: "my journey playing all sorts of games",
  address: "gaming-blog"
},
  {
  title: "Travel Blog",
  description: "Very first travel blog",
  address: "arizona-travels"
}
])
