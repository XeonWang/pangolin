class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @users = User.all
    @subscribe_groups = session[:user_id] && User.find(session[:user_id]).subscribe_groups
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def post_list
    group_id = params[:group] 
    if group_id.to_i > 0
      member_ids = SubscribeGroup.find(group_id).member_ids
      @posts = Post.where("user_id in (?)", member_ids).order("created_at DESC")
    else
      @posts = Post.order("created_at DESC")
    end
    
    respond_to do |format|
      format.json { render json: @posts.to_json(:include => :user) }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_to do |format|
      if session[:user_id]
        format.html # new.html.erb
        format.json { render json: @post }
      else
        format.html { redirect_to new_login_path }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = User.find(session[:user_id])
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def add_comment
    @post = Post.find(params[:id])
    user = User.find(session[:user])
    @comment = Comment.new
    @comment.post = @post
    @comment.user = user
    @comment.content = params[:comment][:content]

    respond_to do |format|
      if @comment.save
        format.html { render action: "show", notice: 'Comment was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      end
    end
  end
end
