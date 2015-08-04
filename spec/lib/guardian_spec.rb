require 'rails_helper'
require 'guardian'

describe Guardian do

  let(:user) { build(:user) }
  let(:another_user) { build(:user) }
  let(:admin) { build(:admin) }

  it 'can be created without a user (not logged in)' do
    expect( lambda{ Guardian.new } ).to_not raise_error
  end

  it 'can be created with a user' do
    expect( lambda{ Guardian.new(:user) } ).to_not raise_error
  end

  describe ".anonymous?" do
    it 'is true for an anonymous user' do
      expect(Guardian.new.anonymous?).to be true
    end

    it 'is false for a registered user' do
      expect(Guardian.new(user).anonymous?).to be false
    end
  end

  describe '.authenticated?' do
    it 'is true for a user' do
      expect(Guardian.new(user).authenticated?).to be true
    end
  end

  describe '.is_admin?' do
    it 'is false for an anonymous user' do
      expect(Guardian.new.is_admin?).to be false
    end

    it 'is false for a normal user' do
      expect(Guardian.new(user).is_admin?).to be false
    end

    it 'is true for an admin' do
      expect(Guardian.new(admin).is_admin?).to be true
    end
  end

  describe '.can_see?' do
    it 'returns false for an anonymous user' do
      expect(Guardian.new.can_see?(another_user)).to be false
    end

    it 'returns false with a nil object' do
      expect(Guardian.new(user).can_see?(nil)).to be false
    end

    context 'a User' do
      it 'returns true for an admin' do
        expect(Guardian.new(admin).can_see?(user)).to be true
      end

      it 'returns for the user' do
        expect(Guardian.new(user).can_see?(user)).to be true
      end

      it 'returns false for others' do
        expect(Guardian.new(user).can_see?(another_user)).to be false
      end
    end

    context 'a Team' do
      let(:team) { create(:team) }

      it 'returns true for an admin' do
        expect(Guardian.new(admin).can_see?(team)).to be true
      end

      it 'returns true for the owner of a team' do
        team.owners << user
        expect(Guardian.new(user).can_see?(team)).to be true
      end

      it 'returns true for a member of a team' do
        team.members << user
        expect(Guardian.new(user).can_see?(team)).to eq true
      end

      it 'returns false for others' do
        expect(Guardian.new(user).can_see?(team)).to be false
      end
    end
  end

    describe '.can_edit?' do
      context 'a User' do
      it 'returns false for an anonymous user' do
        expect(Guardian.new.can_edit?(user)).to be false
      end

      it 'returns false for a non-related user' do
        expect(Guardian.new(user).can_edit?(another_user)).to be false
      end

      it 'returns true for the user' do
        expect(Guardian.new(user).can_edit?(user)).to be true
      end

      it 'returns true for an admin' do
        expect(Guardian.new(admin).can_edit?(user)).to be true
      end

      it 'returns true for an owner of a team' do
        @team = create(:team)
        @team.owners << user
        @team.members << another_user
        expect(Guardian.new(user).can_edit?(another_user)).to be true
      end

      it 'returns true for a lead of a team' do
        @team = create(:team)
        @team.leads << user
        @team.members << another_user
        expect(Guardian.new(user).can_edit?(another_user)).to be true
      end
    end
  end

  describe '.can_administrate_through_team?' do
    before do
      @team = create(:team)
      @member= create(:user)
      @team.members << @member
    end

    it 'returns true for an owner' do
      @team.owners << user
      expect(Guardian.new(user).can_administrate_through_team?(@member)).to be true
    end

    it 'returns true for a lead' do
      @team.leads << user
      expect(Guardian.new(user).can_administrate_through_team?(@member)).to be true
    end

    it 'returns false for a member' do
      @team.members << user
      expect(Guardian.new(user).can_administrate_through_team?(@member)).to be false
    end

    it 'returns false for an unrelated user' do
      expect(Guardian.new(user).can_administrate_through_team?(@member)).to be false
    end
  end
end

