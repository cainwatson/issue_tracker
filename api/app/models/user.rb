class User < ApplicationRecord
  has_many :organizations_created, class_name: "Organization"
end
