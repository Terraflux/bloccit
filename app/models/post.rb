class Post < ActiveRecord::Base
	has_many :comments

	def self.all_with_censored
		posts = Post.all
  		posts.each_with_index do |post, idx|
  			if (idx % 5) == 0
  				posts[idx].title = '[CENSORED]' 
  			end
  		end
  		posts
  	end

end