module Types
  class MutationType < Types::BaseObject
    field :create_user,
          mutation: Mutations::CreateUser,
          description: 'Create a new user.'

    field :create_organization,
          mutation: Mutations::CreateOrganization,
          description: 'Create a new organization.'

    field :create_project,
          mutation: Mutations::CreateProject,
          description: 'Create a new project.'

    field :create_board,
          mutation: Mutations::CreateBoard,
          description: 'Create a new project board.'

    field :create_board_column,
          mutation: Mutations::CreateBoardColumn,
          description: 'Create a new column on a project board.'

    field :create_board_item,
          mutation: Mutations::CreateBoardItem,
          description: 'Create a new item on a project board.'

    field :create_issue,
          mutation: Mutations::CreateIssue,
          description: 'Create a new issue.'

    field :update_organization,
          mutation: Mutations::UpdateOrganization,
          description: 'Update an organization.'

    field :update_issue,
          mutation: Mutations::UpdateIssue,
          description: 'Update an issue.'

    field :move_board_column,
          mutation: Mutations::MoveBoardColumn,
          description: 'Move a column on a board to a new position.'

    field :move_board_item,
          mutation: Mutations::MoveBoardItem,
          description: 'Move an item in a column to a new position.'
  end
end
