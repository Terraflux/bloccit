include RandomData

FactoryGirl.define do
	factory :label do
		name RandomData.random_name
		post
		topic
	end
end