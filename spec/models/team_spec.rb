require 'rails_helper'

describe Team do
  it { should validate_presence_of :name }

  describe 'Relationships' do

    it { should have_many(:team_memberships) }

    it do
      should have_many(:owner_memberships).
        conditions(role: 2).
        class_name('TeamMembership')
    end

    it do
      should have_many(:lead_memberships).
        conditions(role: 1).
        class_name('TeamMembership')
    end

    it do
      should have_many(:member_memberships).
        conditions(role: 0).
        class_name('TeamMembership')
    end

    it do
      should have_many(:members).
        through(:team_memberships).
        source(:user)
    end

    it do
      should have_many(:owners).
        through(:owner_memberships).
        source(:user)
    end

    it do
      should have_many(:leads).
        through(:lead_memberships).
        source(:user)
    end
  end

  describe '.is_lead?' do
    before do
      @team = create(:team)
      @user = create(:user)
    end

    it 'returns false for an unassociated user' do
      expect(@team.is_lead?(@user)).to be false
    end

    it 'returns true for leads' do
      @team.leads << @user
      expect(@team.is_lead?(@user)).to be true
    end
  end

  describe '.is_owner?' do
    before do
      @team = create(:team)
      @user = create(:user)
    end

    it 'returns true for owners' do
      @team.owners << @user
      expect(@team.is_owner?(@user)).to be true
    end

    it 'returns false for an unassociated user' do
      expect(@team.is_owner?(@user)).to be false
    end

    it 'returns false for a member' do
      @team.members << @user
      expect(@team.is_owner?(@user)).to be false
    end

    it 'returns false for lead' do
      @team.lead << @user
      expect(@team.is_owner?(@user)).to be false
    end
  end
end
