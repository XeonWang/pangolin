class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def regist
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    file_param = params[:user][:image_url]
    if file_param then
      fileExtension = File.extname(file_param.original_filename)
      file_name = Time.now().to_i.to_s + fileExtension
      fileFolder = "/images/icons/"
      file_path = File.join('public' + fileFolder, file_name).to_s
      File.open file_path, 'wb' do |f|
        f.write(file_param.read)
      end
      @user.image_url = fileFolder + file_name
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "regist" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def home
    user_id = session[:user_id]
    if user_id
      redirect_to user_path(session[:user_id])
    else
      redirect_to new_login_path
    end  
  end

  def published_posts
    posts = Post.where("user_id = ? and source_id is null", session[:user_id])
    item_template = File.read(Rails.root + "app/views/users/_post_item.jst")
    response = JsonHtmlResponse.new
    response.jst = item_template
    response.data = posts
    respond_to do |format|
      format.json { render json: response }
    end
  end

end
