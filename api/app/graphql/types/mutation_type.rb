module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignIn
    field :sign_up, mutation: Mutations::SignUp

    field :create_organization, mutation: Mutations::CreateOrganization
    field :create_project, mutation: Mutations::CreateProject
    field :create_board, mutation: Mutations::CreateBoard
    field :create_board_column, mutation: Mutations::CreateBoardColumn
    field :create_board_item, mutation: Mutations::CreateBoardItem
    field :create_issue, mutation: Mutations::CreateIssue

    field :update_organization, mutation: Mutations::UpdateOrganization
    field :update_issue, mutation: Mutations::UpdateIssue

    field :move_board_column, mutation: Mutations::MoveBoardColumn
    field :move_board_item, mutation: Mutations::MoveBoardItem
  end
end
