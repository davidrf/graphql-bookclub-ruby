# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  user = User.create!({
    bio: Faker::Lorem.paragraphs.join(" "),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    picture_url: Faker::LoremFlickr.image,
    username: "#{Faker::Internet.username}#{Time.current.to_i}",
  })

  repository_names = [
    "angular",
    "elixir",
    "ember",
    "graphql",
    "go",
    "phoenix",
    "rails",
    "react",
    "ruby",
    "vue",
  ].sample(5)

  repository_names.each do |name|
    Repository.create!({
      name: name,
      user: user,
    })
  end
end