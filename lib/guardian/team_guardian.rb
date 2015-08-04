module TeamGuardian

  def can_see_team?(team)
    is_admin? || team.is_staff?(user) || team.is_member?(user)
  end

   def can_edit_team?(team)
    is_admin? || team.is_staff?(user)
  end

	def can_create_membership? membership
		return false if anonymous? || !authenticated? || (!membership.present?) || (!membership.team.present?)
		is_owner_of_team?(membership) || is_lead_of_team?(membership)
	end

	def is_owner_of_team? membership
		membership.team.is_owner?(user)
	end

	def is_lead_of_team? membership
		membership.team.is_lead?(user)
	end

	 def is_staff_member_creating_equal_or_lower? membership
    membership.team.is_staff?(user) && (membership.role.in? %w(lead member))
  end
end