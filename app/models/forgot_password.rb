class ForgotPassword
  include ActiveModel::Model

  attr_accessor(
    :id,
    :email,
    :admin,
    :password
  )

end
