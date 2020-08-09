require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "name should be present" do
    organization = Organization.new
    refute organization.valid?
  end

  test "name should be unique" do
    existing_organization = organizations[0]
    organization = Organization.new(name: existing_organization.name)
    refute organization.valid?
  end
end
