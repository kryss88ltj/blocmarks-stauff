class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic_id])
    @topic = current_user.topics.build(topic_params)

 
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was a problem saving your Topic. Please try again ( 　･ิω･ิ)"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to be an admin to do that（；へ：）!"
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it."
    if @topic.update_attributes(topic_params)
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    title = @topic.title
    authorize! :destroy, @topic, message: "You need to own the topic to delete it."
    if @topic.destroy
      redirect_to topics_path, notice: "\"#{title}\" was deleted successfully."
    else 
      flash[:error] = "Error deleting topic. Please try again."
      render :show
    end
  end


  def topic_params
    params.require(:topic).permit(:title)
  end
end
