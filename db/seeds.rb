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
	Post.create!(
		user: users.sample,
		topic: topics.sample,
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph
	)
end

posts = Post.all

100.times do
	Comment.create!(
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

user = User.first
user.update_attributes!(
	email: 'pedro.urbina@gmail.com',
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
