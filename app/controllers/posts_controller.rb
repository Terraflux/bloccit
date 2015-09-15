class PostsController < ApplicationController

  before_action :find_topic
  before_action :find_post
  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: :show

  def show
  end

  def new
  	@post = Post.new
  end

  def create
    @post = @topic.posts.build(post_params)
    @post.user = current_user

  	if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
  		flash[:notice] = "Post was saved."
  		redirect_to [@topic, @post]
  	else
  		flash[:error] = "There was an error saving the post. Please try again."
  		render :new
  	end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)
    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was a problem updating the post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully"
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post ||= Post.find(params[:id]) if params[:id]
  end

  def find_topic
    @topic ||= Topic.find(params[:topic_id]) if params[:topic_id]
  end

  def authorize_user
    case action_name
    when 'create', 'new'
      return if (current_user.admin? || current_user.member?)
    when 'update', 'edit'
      return if (current_user.admin? || current_user.moderator? || current_user == @post.user)
    when 'destroy'
      return if (current_user.admin? || current_user == @post.user)
    end
    flash[:error] = "You must be an admin to do that."
    redirect_to (@post ? [@post.topic, @post] : @topic)
  end
end
