class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :email,
    :admin,
    :created_at,
    :updated_at,
    :last_login,
    :active
  )
end
