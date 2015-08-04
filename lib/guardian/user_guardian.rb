module UserGuardian

  def can_see_user?(user)
    is_me?(user) || is_admin? || is_staff?
  end
  alias :can_edit_user? :can_see_user?
end
