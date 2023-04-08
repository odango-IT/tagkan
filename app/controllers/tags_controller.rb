class TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.where(user_id:current_user.id).order(created_at: :desc)
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "タグを追加しました"
    else
      render :new
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_path, notice: "タグを削除しました"
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
