class LoginsController < ApplicationController
  # GET /logins
  # GET /logins.json
  def index
    @logins = Login.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
    @login = Login.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
    @login = Login.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/1/edit
  def edit
    @login = Login.find(params[:id])
  end

  # POST /logins
  # POST /logins.json
  def create
    @user = User.where(["name = ?", params[:user][:name]]).first
    @login = Login.new()
    @login.action = Login.LOGIN
    saved = false
    if @user && @user.pwd == params[:user][:pwd] then
      @login.user = @user
      saved = @login.save
      session[:user_name] = @user.name
    else
      @login.errors.add(:Failed, 'User name or password incorrect!')
    end
    respond_to do |format|
      if saved
        format.html { redirect_to @login, notice: 'Login Success!' }
        format.json { render json: @login, status: :created, location: @login }
      else
        format.html { render action: "new" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logins/1
  # PUT /logins/1.json
  def update
    @login = Login.find(params[:id])

    respond_to do |format|
      if @login.update_attributes(params[:login])
        format.html { redirect_to @login, notice: 'Login was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  def destroy
    @user = User.where(["name = ?", session[:user_name]]).first
    @login = Login.new()
    @login.action = Login.LOGOUT
    @login.user = @user
    @login.save
    session[:user_name] = nil
    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: @login.errors, status: :unprocessable_entity }
    end
  end
end
