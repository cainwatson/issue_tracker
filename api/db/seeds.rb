# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
  amount.times do |num|
    issue = Issue.create(
      summary: "#{column.name} #{num + 1}",
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

5.times do |num|
  user = Accounts::User.create
  _profile = Profiles::Profile.create(
    user: user,
    first_name: "User ##{num}",
    last_name: 'Test'
  )
end

users = Accounts::User.all.to_a

organizations = users.map.with_index do |user, index|
  Organizations::Organization.create(
    name: "Org #{index + 1}",
    user_creator: user
  )
end

projects = organizations.flat_map.with_index do |organization, index|
  [
    Project.create(
      name: "Project #{index + 1}",
      owner: organization,
      user_creator: organization.user_creator
    ),
    Project.create(
      name: "User Project #{index + 1}",
      owner: organization.user_creator,
      user_creator: organization.user_creator
    )
  ]
end

projects.each do |project|
  create_board(project: project)
end
