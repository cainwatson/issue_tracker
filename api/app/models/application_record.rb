class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def node_id
    IssueTrackerSchema.id_from_object(self, nil, {})
  end
end
