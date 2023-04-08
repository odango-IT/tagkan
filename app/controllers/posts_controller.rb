class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    redirect_to '/'
  end

  # GET /posts/1 or /posts/1.json
  def show
    redirect_to edit_post_path(set_post)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    tags = PostTag.where(post_id: @post.id)
    tags_list_str = []
    for tag in tags do
      tag_str = Tag.find(tag.tag_id)
      tags_list_str.push(tag_str.name)
    end
    @tags_str = tags_list_str.join(',')
    #puts tag_str.name

  end

  # POST /posts or /posts.json
  def create
    upload_file = params[:post][:file]
    if upload_file.present?
      upload_file_name = random_string(20)+upload_file.original_filename
      upload_dir = Rails.root.join("public", "user_file")
      upload_file_path = upload_dir + upload_file_name
      db_upload_file_path = "/user_file/" + upload_file_name
      File.binwrite(upload_file_path, upload_file.read)
    end

    @post = Post.new(name: params[:post][:name], path: db_upload_file_path, user_id: current_user.id)

    tags_str = params[:post][:tag]
    tags_list_str = tags_str.split(',')



    respond_to do |format|
      if @post.save
        for tag_str in tags_list_str do
          tag = Tag.find_by(name:tag_str)
          @post_tag = PostTag.new(post_id: @post.id, tag_id: tag.id)
          @post_tag.save
        end
        format.html { redirect_to '/', notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to '/', notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to '/', notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :path, :user_id)
    end
end
