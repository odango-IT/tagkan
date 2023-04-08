class TopController < ApplicationController
  def index
    if user_signed_in?
      @posts = Post.where(user_id:current_user.id).order(created_at: :desc)
    else
      redirect_to  '/login'
    end
  end

  def search
    tags_str = params[:tags]
    
  end

  def result
    tags_str = params[:tags]
    @posts = []
    p tags_str
    tags_list_str = tags_str.split('+')
    for tag_str in tags_list_str do
      tag = Tag.find_by(name:tag_str)
      post_ids = PostTag.where(tag_id:tag.id)
      for post in post_ids do
        @posts.push(Post.find(post.post_id))
      end
    end

    render :index
  end
end
