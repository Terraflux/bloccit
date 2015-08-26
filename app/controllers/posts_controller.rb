class PostsController < ApplicationController
  def index
  	# @posts = Post.all
  	# @posts.each_with_index do |post, idx|
  	# 	if (idx % 5) == 0
  	# 		@posts[idx].title = '[CENSORED]' 
  	# 	end
  	# end
  	@posts = Post.all_with_censored
  	
  end

  def show
  	@post = Post.find params[:id]
  end

  def new
  end

  def edit
  end
end
