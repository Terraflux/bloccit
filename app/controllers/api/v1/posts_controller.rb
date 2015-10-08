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

	def update
		post = Post.find(params[:id])
		if post.update_attributes(post_params)
			render json: post.to_json, status: 200
		else
			render json: {error: "Post update failed", status: 400}, status: 400
		end
	end

	def create
		post = @topic.posts.build(post_params)
		post.user = current_user
		if post.valid?
			post.save!
			render json: post.to_json, status: 200
		else
			render json: {error: "Post update failed", status: 400}, status: 400
		end
	end

	def destroy
		post = Post.find(params[:id])
		if post.destroy
			render json: {message: "Post destroyed", status: 200}, status: 200
		else
			render json: {error: "Post destroy failed", status: 400}, status: 400
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end


end