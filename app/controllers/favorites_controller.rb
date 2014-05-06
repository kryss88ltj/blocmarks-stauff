class FavoritesController < ApplicationController
  respond_to :html, :js

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Favorite, messsage: "You cannot do that!"
    favorite = current_user.favorites.create(post: @post)
    if favorite.save
      flash.now[:notice] = "Favorited post"     
    else
      flash.now[:error] = "Unable to add favorite. Please try again."
    end

    respond_with(@favorite) do |f|
      f.html { redirect_to [ @post, @favorite] }
    end
  end

  def destroy
  @topic = Topic.find(params[:topic_id])
  @post = @topic.posts.find(params[:post_id])
  @favorite = current_user.favorites.find(params[:id])

    authorize! :destroy, @favorite, message: "You cannot do that!"

    if @favorite.destroy
      flash.now[:notice] = "Removed favorite."
   else
      flash.now[:error] = "Unable to remove favorite. Please try again."
    end

    respond_with(@favorite) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

end