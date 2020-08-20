module Types
  class ProjectOwnerType < Types::BaseEnum
    value "ACCOUNT", "A user account owns the project.", value: "Accounts::User"
    value "ORGANIZATION", "An organization owns the project.", value: "Organizations::Organization"
  end
end
