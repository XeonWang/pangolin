class LoginsController < ApplicationController

  # GET /logins/new
  # GET /logins/new.json
  def new
    @login = Login.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @login }
    end
  end

  # POST /logins
  # POST /logins.json
  def create
    @user = User.where(["name = ?", params[:user][:name]]).first
    fsize = @user.favorites.size
    @login = Login.new
    @login.action = Login.LOGIN
    saved = false
    if @user && @user.pwd.to_s == params[:user][:pwd] then
      @login.user = @user
      saved = @login.save
      session[:user_id] = @user.id
      session[:user_name] = @user.name
    else
      @login.errors.add(:Failed, 'User name or password incorrect!')
    end
    respond_to do |format|
      if saved
        format.html { redirect_to root_path, notice: 'Login Success!' }
        format.json { render json: @login, status: :created, location: @login }
      else
        format.html { render action: "new" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  def destroy
    @user = User.where(["name = ?", session[:user_name]]).first
    @login = Login.new
    @login.action = Login.LOGOUT
    @login.user = @user
    @login.save
    session[:user_id] = nil
    session[:user_name] = nil
    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: @login.errors, status: :unprocessable_entity }
    end
  end
end
