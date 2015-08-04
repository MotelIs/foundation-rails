class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  has_many :other_members_of_team

  enum role: %w(member lead owner)

 	validates_uniqueness_of :user_id, scope: :team_id
 	validates :user, presence: true
 	validates :team, presence: true
 	validates :role, presence: true

 	def self.is_employee_of_member?(owner, member)
 		sql = "SELECT x.*
 		FROM team_memberships p
		INNER JOIN team_memberships x
			ON x.team_id = p.team_id AND x.role = 0
		WHERE p.user_id = ? AND p.role IN (2,1) AND x.user_id = ?"

		test = TeamMembership.find_by_sql [sql, owner.id, member.id]
		test[0].present?
	end
end
