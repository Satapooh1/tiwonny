class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update, :destroy ]
  # GET /posts or /posts.json
  def index
    if params[:search].present?
      @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)  # ใช้ current_user เชื่อมโยงโพสต์กับผู้ใช้ที่ล็อกอิน
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy  # ใช้ destroy แทน destroy! เพื่อหลีกเลี่ยงข้อผิดพลาด
    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # ใช้ callbacks เพื่อแชร์ setup หรือ constraints ที่ใช้บ่อย
    def set_post
      @post = Post.find(params[:id])
    end

    def correct_user
      redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
    end
    # อนุญาตให้รับพารามิเตอร์ที่เชื่อถือได้
    def post_params
      params.require(:post).permit(:title, :content, :anonymous)  # ไม่รับ :user_id เพราะใช้ current_user แทน
    end
end
