class TeamMembershipSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :team_id

  belongs_to :user
  belongs_to :team
end
