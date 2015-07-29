class Team < ActiveRecord::Base

  validates :name, presence: true

  has_many :users, through: :team_memberships
  has_many :team_memberships

  has_many :member_memberships, -> { where(role: 0) },
    class_name: 'TeamMembership'
  has_many :lead_memberships, -> { where(role: 1) },
  	class_name: 'TeamMembership'
  has_many :owner_memberships, -> { where(role: 2) },
  	class_name: 'TeamMembership'

  has_many :members, through: :member_memberships, source: :user
  has_many :owners, through: :owner_memberships, source: :user
  has_many :leads, through: :lead_memberships, source: :user

  def is_lead? user
    lead_memberships.where(user: user).exists?
  end

  def is_owner? user
    owner_memberships.where(user: user).exists?
  end

  def is_member? user
    member_memberships.where(user: user).exists?
  end

  def is_staff? user
    owner_memberships.where(user: user).exists? ||
    lead_memberships.where(user: user).exists?
  end
end
