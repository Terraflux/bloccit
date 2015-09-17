include RandomData

5.times do
	user = User.create!(
		name: RandomData.random_name,
		email: RandomData.random_email,
		password: RandomData.random_sentence
	)
end
users = User.all

15.times do
	Topic.create!(
		name: RandomData.random_sentence, 
		description: RandomData.random_paragraph
	)
end
topics = Topic.all

50.times do
	post = Post.create!(
		user: users.sample,
		topic: topics.sample,
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph
	)
	post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
	rand(1..5).times{post.votes.create!(value:[-1, 1].sample, user: users.sample)}
end

posts = Post.all

100.times do
	Comment.create!(
		user: users.sample,
		post: posts.sample,
		body: RandomData.random_paragraph
	)
end
comments = Comment.all

25.times do
	Advertisement.create!(
		title: RandomData.random_sentence,
		copy: RandomData.random_paragraph,
		price: RandomData.random_number
	)
end
advertisements = Advertisement.all

10.times do
	Question.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
	)
end
questions = Question.all

5.times do
	SponsoredPost.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
		price: RandomData.random_number
		)
end
sposts = SponsoredPost.all

qpost = Post.find_or_create_by(
	title: "Test Post",
	body: "Test Body"
)

qcom = Comment.find_or_create_by(
	post: posts.first,
	body: "Body"
)

admin = User.create!(
	name: 'Admin User',
	email: 'admin@example.com',
	password: 'helloworld',
	role: 'admin'
)

member = User.create!(
	name: 'Member User',
	email: 'member@example.com',
	password: 'helloworld'
)

mod = User.create!(
	name: 'Mod User',
	email: 'mod@example.com',
	password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
puts "#{Question.count} questions created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Vote.count} votes created"
