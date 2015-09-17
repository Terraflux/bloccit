require 'rails_helper'
include RandomData

RSpec.describe Vote, type: :model do
	let(:topic){Topic.create!(name: RandomData.random_sentence, description: RandomData.random_sentence)}
	let(:user){User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
	let(:post){topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)}
	let(:vote){Vote.create!(value: 1, post: post, user: user)}

	it {should belong_to(:post)}
	it {should belong_to(:user)}
	it {should validate_presence_of(:value)}
	it {should validate_inclusion_of(:value).in_array([-1, 1])}
end