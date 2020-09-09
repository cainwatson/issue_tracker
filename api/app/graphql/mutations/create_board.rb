module Mutations
  class CreateBoard < Mutations::BaseMutation
    description 'Create a new project board.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :project_id, ID, required: true, loads: Types::ProjectType
    argument :name, String, required: true

    field :board, Types::BoardType, null: true
    field :errors, [String], null: true

    def resolve(user_creator:, project:, name:)
      board = Projects::Board.create(
        name: name,
        user_creator: user_creator,
        project: project
      )

      if board.invalid?
        { errors: board.errors.full_messages }
      else
        { board: board }
      end
    end
  end
end
