module Types
  class ProjectOwnerCategory < Types::BaseEnum
    value 'ACCOUNT', 'A project owned by a user account.', value: 'Accounts::User'
    value 'ORGANIZATION', 'A project owned by an organization.', value: 'Organizations::Organization'
  end
end
