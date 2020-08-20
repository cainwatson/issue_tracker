require "test_helper"

class FetchUserProjectsQueryTest < ActiveSupport::TestCase
  test "returns the user's projects" do
    query_string = <<-GRAPHQL
      query fetchUserprojects($id: ID!) {
        user(id: $id) {
          id
          projects {
            id
            name
            photoUrl
            isPrivate
            userCreatorId
            ownerType
            ownerId
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    user_projects = [projects_projects(:megans)]

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => user.id})
    user_result = result["data"]["user"]

    assert_equal user_result["projects"], [
      {
        "id" => user_projects[0].id,
        "name" => user_projects[0].name,
        "photoUrl" => user_projects[0].photoUrl,
        "isPrivate" => user_projects[0].isPrivate,
        "userCreatorId" => user_projects[0].userCreatorId,
        "ownerType" => user_projects[0].ownerType,
        "ownerId" => user_projects[0].ownerId,
        "createdAt" => user_projects[0].createdAt,
        "updatedAt" => user_projects[0].updatedAt,
      },
    ]
  end
end
