require_dependency 'guardian/ensure_magic'
require_dependency 'guardian/user_guardian'
require_dependency 'guardian/team_guardian'

class Guardian
  include EnsureMagic
  include TeamGuardian
  include UserGuardian

  class AnonymousUser
    def blank?; true; end
    def admin?; false; end
    def email; nil; end;
  end

  def initialize(user=nil)
    @user = user.presence || AnonymousUser.new
  end

  def user
    @user.presence
  end
  alias :current_user :user

  def anonymous?
    !authenticated?
  end

  def authenticated?
    @user.present?
  end

  def is_admin?
    @user.admin?
  end

  def can_see?(obj)
    can_do?(:see, obj)
  end

  def can_edit?(obj)
    can_do?(:edit, obj)
  end

  def can_administrate_through_team?(other)
    TeamMembership.is_employee_of_member?(user, other)
  end

  private

  def method_name_for(action, obj)
    method_name = :"can_#{action}_#{obj.class.name.underscore}?"
    return method_name if respond_to?(method_name)
  end

  def is_me?(other)
    other && authenticated? && other.is_a?(User) && @user == other
  end

  def can_do?(action, obj)
    if obj && authenticated?
      action_method = method_name_for action, obj
      return (action_method ? send(action_method, obj) : true)
    else
      false
    end
  end
end
