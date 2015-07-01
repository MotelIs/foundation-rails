class RoleSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :created_at, :updated_at

  belongs_to :user
end
