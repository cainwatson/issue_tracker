require "test_helper"

class FetchUserProjectsQueryTest < ActiveSupport::TestCase
  test "returns the user's projects" do
    query_string = <<-GRAPHQL
      query fetchUserProjects($id: ID!) {
        user(id: $id) {
          id
          projects {
            id
            name
            photoUrl
            isPrivate
            ownerType
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => user.id})
    user_result = result["data"]["user"]

    user.projects.each_with_index do |project, index|
      project_result = user_result["projects"][index]

      assert project_result["id"]
      assert project_result["createdAt"]
      assert project_result["updatedAt"]
      assert_equal project_result["ownerType"], "ACCOUNT"
      assert_equal project_result["name"], project.name
      assert_equal project_result["photoUrl"], project.photo_url
      assert_equal project_result["isPrivate"], project.is_private
    end
  end
end
