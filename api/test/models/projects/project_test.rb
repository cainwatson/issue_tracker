require 'test_helper'

class Projects::ProjectTest < ActiveSupport::TestCase
  test "name should be present" do
    project = Projects::Project.new(
      user_creator: accounts_users(:tyler),
      owner: organizations_organizations(:one),
    )
    assert project.invalid?

    project.name = "project name"
    assert project.valid?
  end

  test "name should be unique per owner" do
    project = Projects::Project.new(
      user_creator: accounts_users(:megan),
      owner: accounts_users(:megan),
      name: projects_projects(:megans).name,
    )
    assert project.invalid?

    project.name = "unique project name"
    assert project.valid?
  end
end
