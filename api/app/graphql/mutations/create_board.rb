module Mutations
  class CreateBoard < Mutations::BaseMutation
    null true

    argument :name, String, required: true
    argument :user_creator_id, ID, required: true
    argument :project_id, ID, required: true

    field :board, Types::BoardType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      project = IssueTrackerSchema.object_from_id(args[:project_id])

      board = Projects::Board.create(
        name: args[:name],
        user_creator: user_creator,
        project: project
      )

      return { errors: board.errors.full_messages } if board.invalid?

      {
        board: board,
        errors: []
      }
    end
  end
end
