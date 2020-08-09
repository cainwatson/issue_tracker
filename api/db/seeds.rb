# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |num|
  Accounts::User.create()
end

users = Accounts::User.all().to_a

organizations = users.map.with_index do |user, index|
  Organizations::Organization.create(
    name: "Org #{index + 1}",
    user_creator: user
  )
end

projects = organizations.flat_map.with_index do |organization, index|
  [
    Projects::Project.create(
      name: "Project #{index + 1}",
      owner: organization,
      user_creator: organization.user_creator
    ),
    Projects::Project.create(
      name: "User Project #{index + 1}",
      owner: organization.user_creator,
      user_creator: organization.user_creator
    )
  ]
end

projects.each do |project|
  4.times do |num|
    Projects::Issue.create(
      summary: "Issue #{num}",
      project: project,
      user_creator: project.user_creator
    )
  end
end
