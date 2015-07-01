class UserRegistrationSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :email
  )

  def id
    object.try(:id)
  end
end
