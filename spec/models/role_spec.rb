require 'spec_helper'

describe Role do

  it { is_expected.to validate_presence_of(:user) }
end
