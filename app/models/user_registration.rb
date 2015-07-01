class UserRegistration
  include ActiveModel::Model

  attr_accessor(
    :id,
    :email,
    :admin,
    :created_at,
    :updated_at,
    :last_login,
    :active
  )
end
