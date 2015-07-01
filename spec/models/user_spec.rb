require 'rails_helper'

describe User do
  it { is_expected.to have_db_index(:email) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to allow_value("foo@example.co.uk").for(:email) }
  it { is_expected.to allow_value("foo@example.com").for(:email) }
  it { is_expected.to allow_value("FOO@example.com").for(:email) }
  it { is_expected.to allow_value("foo+bar@example.com").for(:email) }

  it { is_expected.not_to allow_value("foo@").for(:email) }
  it { is_expected.not_to allow_value("foo@example..com").for(:email) }
  it { is_expected.not_to allow_value("foo@.example.com").for(:email) }
  it { is_expected.not_to allow_value("foo").for(:email) }
  it { is_expected.not_to allow_value("example.com").for(:email) }
  it { is_expected.not_to allow_value("foo;@example.com").for(:email) }

  context "user password should be a minimum of 8 characters"
  it do
    should validate_length_of(:password).
      is_at_least(8).
     on(:create)
  end

  describe "#email" do
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  context "user password should be present"
  it do
    should validate_presence_of(:password)
  end
end


