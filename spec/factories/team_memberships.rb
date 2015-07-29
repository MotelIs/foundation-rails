FactoryGirl.define do
	factory :team_membership do
		user
		team

		trait :lead do
			role :lead
		end

		trait :member do
			role :member
		end

		trait :owner do
			role :owner
		end

		factory :owner_membership, traits: [:owner]
		factory :lead_membership, traits: [:lead]
		factory :member_membership, traits: [:member]
	end
end
