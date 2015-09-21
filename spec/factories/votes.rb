include RandomData

FactoryGirl.define do
	factory :vote do
		value RandomData.randomplusminus
		post
		user
	end
end