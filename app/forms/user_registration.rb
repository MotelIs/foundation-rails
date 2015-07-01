class UserRegistration
  include ActiveModel::Model

  attr_accessor(
    :email,
    :password,
    :password_confirmation
  )

  validates :email,
    presence: true,
    format: User::VALID_EMAIL_REGEX

  validates :password,
    presence: true,
    confirmation: true

  validates :password_confirmation, presence: true

  validate do
    if User.where(email: email).exists?
      errors.add :email, "This email is already in use"
    end
  end

  def register
    if valid?
      user = find_or_create_user
    end
  end

  def find_or_create_user
    return existing_user if existing_user.present?
    create_user
  end

  def existing_user
    @user ||= User.find_by email: email
    @user
  end

  def create_user
    user = User.create(email: email, partially_registered: true, password: password, password_confirmation: password_confirmation)
    user
  end
end
