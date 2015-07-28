class Team < ActiveRecord::Base
  has_many :users, through: :team_memberships
  has_many :team_memberships
  has_many :leader_memberships, -> { where(role: ‘leader’) }

  validates :name, presence: true
end
