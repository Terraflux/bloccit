require 'rails_helper'
include RandomData

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic){Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:my_spost){my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

  describe "GET show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(response).to render_template :show
    end

    it "assigns my_spost to @spost" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(assigns(:sponsored_post)).to eq(my_spost)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "Post create" do
    it "increases the number of Post by 1" do
      expect{post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(SponsoredPost,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, topic_id: my_topic.id , sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end

    it "redirects to the new post" do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end


  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      spost_instance = assigns(:sponsored_post)
      expect(spost_instance.id).to eq my_spost.id
      expect(spost_instance.title).to eq my_spost.title
      expect(spost_instance.body).to eq my_spost.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, topic_id: my_topic.id, id: my_spost.id, sponsored_post: {title: new_title, body: new_body}
      updated_spost = assigns(:sponsored_post)
      expect(updated_spost.id).to eq my_spost.id
      expect(updated_spost.title).to eq new_title
      expect(updated_spost.body).to eq new_body
    end
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, topic_id: my_topic.id,id: my_spost.id, sponsored_post: {title: new_title, body: new_body}
      expect(response).to redirect_to [my_topic, my_spost]
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, topic_id: my_topic.id, id: my_spost.id
      count = SponsoredPost.where({id: my_spost.id}).size
      expect(count).to eq 0
    end
    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_spost.id
      expect(response).to redirect_to my_topic
    end
  end

end
