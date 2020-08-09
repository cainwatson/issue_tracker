require 'test_helper'

class Projects::IssueTest < ActiveSupport::TestCase
  test "summary should be present" do
    issue = Projects::Issue.new(
      user_creator: accounts_users(:tyler),
      project: projects_projects(:tylers),
    )
    assert issue.invalid?

    issue.summary = "issue summary"
    assert issue.valid?
  end
end
