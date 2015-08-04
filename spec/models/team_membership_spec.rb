require 'rails_helper'

describe TeamMembership do

  it { should belong_to :user }
  it { should belong_to :team }

  it { should define_enum_for(:role) }

  it { should validate_presence_of :user }
  it { should validate_presence_of :team }
  it { should validate_presence_of :role }

  it { should validate_uniqueness_of(:user_id).scoped_to(:team_id) }

end
