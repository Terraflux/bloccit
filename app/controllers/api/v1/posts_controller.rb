class Api::V1::PostsController < Api::V1::BaseController

	before_filter :authenticate_user, except: [:show, :index]
	before_filter :authorize_user, except: [:show, :index]

	def index
		posts = Post.all
		render json: posts.to_json, status: 200
	end

	def show
		post = Post.find(params[:id])
		render json: post.to_json, status: 200
	end


end