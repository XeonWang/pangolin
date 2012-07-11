class RegistsController < ApplicationController
  # GET /regists
  # GET /regists.json
  def index
    @regist = User.new
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @user }
    # end
    render "users/regist"
  end

  # GET /regists/1
  # GET /regists/1.json
  def show
    @regist = Regist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @regist }
    end
  end

  # GET /regists/new
  # GET /regists/new.json
  def new
    @regist = Regist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @regist }
    end
  end

  # GET /regists/1/edit
  def edit
    @regist = Regist.find(params[:id])
  end

  # POST /regists
  # POST /regists.json
  def create
    @regist = Regist.new(params[:regist])

    respond_to do |format|
      if @regist.save
        format.html { redirect_to @regist, notice: 'Regist was successfully created.' }
        format.json { render json: @regist, status: :created, location: @regist }
      else
        format.html { render action: "new" }
        format.json { render json: @regist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /regists/1
  # PUT /regists/1.json
  def update
    @regist = Regist.find(params[:id])

    respond_to do |format|
      if @regist.update_attributes(params[:regist])
        format.html { redirect_to @regist, notice: 'Regist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @regist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regists/1
  # DELETE /regists/1.json
  def destroy
    @regist = Regist.find(params[:id])
    @regist.destroy

    respond_to do |format|
      format.html { redirect_to regists_url }
      format.json { head :no_content }
    end
  end
end
