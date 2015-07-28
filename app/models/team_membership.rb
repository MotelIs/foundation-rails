class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  ROLE = %w(member lead owner)

 	validates_uniqueness_of :user_id, scope: :team_id
 	validates :user, presence: true
 	validates :team, presence: true
 	validates :role, presence: true
end
