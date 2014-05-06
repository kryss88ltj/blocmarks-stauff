class Topics::PostsController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new

  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(post_params)
    if current_user
      @post = current_user.posts.build(post_params)
    end
    @posts = @topic.posts

    @post.topic = @topic
   
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic]
    else
      flash[:error] = "There was a problem saving your link. Please try again =^_^="
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end
  
  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
  
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    url = @post.url
    
    if @post.destroy
        flash[:notice] = "Post was deleted."
        redirect_to @topic
    else
        flash[:error] = "There was an error deleting the post. Please try again."
        redirect_to @topic
    end
  end

  def post_params
    params.require(:post).permit(:url)
  end

end
