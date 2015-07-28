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
	end
end
