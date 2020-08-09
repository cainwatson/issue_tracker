require 'test_helper'

class Projects::ProjectTest < ActiveSupport::TestCase
  test "name should be present" do
    project = Projects::Project.new(
      user_creator: users(:tyler),
      organization: organizations(:one),
    )
    assert project.invalid?

    project.name = "project name"
    assert project.valid?
  end

  test "name should be unique in organization" do
    project = Projects::Project.new(
      user_creator: users(:megan),
      organization: organizations(:two),
      name: projects_projects(:two).name,
    )
    assert project.invalid?

    project.name = "unique project name"
    assert project.valid?
  end
end
