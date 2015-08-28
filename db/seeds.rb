include RandomData

50.times do
	Post.create!(
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

25.times do
	Advertisement.create!(
		title: RandomData.random_sentence,
		copy: RandomData.random_paragraph,
		price: RandomData.random_number
	)
end

10.times do
	Question.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
	)
end

qpost = Post.find_or_create_by(
	title: "Test Post",
	body: "Test Body"
)

qcom = Comment.find_or_create_by(
	post: posts.first,
	body: "Body"
)

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
puts "#{Question.count} questions created"