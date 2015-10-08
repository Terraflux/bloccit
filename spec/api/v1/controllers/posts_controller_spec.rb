require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
	let(:my_user){create(:user)}
	let(:my_topic){create(:topic)}
	let(:my_post){create(:post, topic: my_topic, user: my_user)}

	context "unauthenticated user" do
		
		it "GET index returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end	

		it "GET show returns http success" do
			get :show, topic_id: my_topic.id, id: my_post.id
			expect(response).to have_http_status(:success)
		end

		it "PUT update returns http unauthenticated" do
			put :update, topic_id: my_topic.id, id: my_post.id, post: {title: "Post Title", body: "Post bodies are supposed to be a certain length or they won't be accepted."}
			expect(response).to have_http_status(401)
		end

		it "POST create returns http unauthenticated" do
			post :create, topic_id: my_topic.id, post: {title: "Post Title", body: "Post bodies are supposed to be a certain length or they won't be accepted."}
			expect(response).to have_http_status(401)
		end

		it "DELETE destroy returns http unauthenticated" do
			delete :destroy, topic_id: my_topic.id, id: my_post.id
			expect(response).to have_http_status(401)
		end
	end

	context "unauthorized user" do
		before do
			controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
		end
		it "GET index returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
		it "GET show returns http success" do
			get :show, topic_id: my_topic.id, id: my_post.id
			expect(response).to have_http_status(:success)
		end
		it "PUT update returns http unauthorized" do
			put :update, topic_id: my_topic.id, id: my_post.id, post: {title: "Post Title", body: "Post bodies are supposed to be a certain length or they won't be accepted."}
			expect(response).to have_http_status(403)
		end
		it "POST create returns http unauthorized" do
			post :create, topic_id: my_topic.id, post: {title: "Post Title", body: "Post bodies are supposed to be a certain length or they won't be accepted."}
			expect(response).to have_http_status(403)
		end
		it "DELETE destroy returns http unauthorized" do
			delete :destroy, topic_id: my_topic.id, id: my_post.id
			expect(response).to have_http_status(403)
		end
	end

	context "authorized and authenticated user" do
		before do
			my_user.admin!
			controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
			@new_post = build(:post)
		end

		describe "PUT update" do
			before {put :update, id: my_post.id, post: {title: @new_post.title, body: @new_post.body}}
			it "returns http success" do
				expect(response).to have_http_status(:success)
			end
			it "returns json content type" do
				expect(response.content_type).to eq 'application/json'
			end
			it "updates a post with the correct attributes" do
				expect(my_post.title).to eq @new_post.title
				expect(my_post.body).to eq @new_post.body
			end
		end
	end
end