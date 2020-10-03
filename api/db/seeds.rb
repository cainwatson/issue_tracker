# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

include Projects

def create_board(project:)
  board = Board.create(
    name: "#{project.name}'s board'",
    project: project,
    user_creator: project.user_creator
  )

  todo = BoardColumn.create(name: 'Todo', board: board, user_creator: project.user_creator)
  in_progress = BoardColumn.create(name: 'In Progress', board: board, user_creator: project.user_creator)
  in_review = BoardColumn.create(name: 'In Review', board: board, user_creator: project.user_creator)
  done = BoardColumn.create(name: 'Done', board: board, user_creator: project.user_creator)

  add_issues_to_column(amount: 6, column: todo)
  add_issues_to_column(amount: 2, column: in_progress)
  add_issues_to_column(amount: 1, column: in_review)
  add_issues_to_column(amount: 3, column: done)
end

def add_issues_to_column(amount:, column:)
  amount.times do |_num|
    issue = Issue.create(
      summary: Faker::Company.bs,
      description: Faker::Lorem.paragraph,
      project: column.board.project,
      user_creator: column.user_creator
    )
    BoardItem.create(
      board: column.board,
      issue: issue,
      column: column,
      user_creator: column.user_creator
    )
  end
end

5.times do |_num|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = Accounts::User.create(
    email: Faker::Internet.safe_email(name: first_name),
    password: 'password'
  )
  _profile = Profiles::Profile.create(
    user: user,
    first_name: first_name,
    last_name: last_name,
    photo_url: Faker::Avatar.image
  )
end

users = Accounts::User.all.to_a

users.map.with_index do |user, _user_index|
  10.times do |_project_index|
    Project.create(
      name: Faker::Superhero.name,
      owner: user,
      user_creator: user
    )
  end
end

organizations = users.map.with_index do |user, _index|
  Organizations::Organization.create(
    name: Faker::Company.name,
    user_creator: user,
    photo_url: Faker::Company.logo
  )
end

organizations.flat_map.with_index do |organization, _index|
  [
    Project.create(
      name: Faker::Superhero.name,
      owner: organization,
      user_creator: organization.user_creator
    )
  ]
end

projects = Project.all.to_a

projects.each do |project|
  create_board(project: project)
end
