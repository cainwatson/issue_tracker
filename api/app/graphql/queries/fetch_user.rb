module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      User.find(id)
    rescue ActiveRecord::RecordNotFound => _error
      nil
    end
  end
end