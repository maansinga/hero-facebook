require 'net/http'

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

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    access_token=params[:user][:access_token]
    uri= URI.parse('https://graph.facebook.com/me')
    args= {:access_token=>access_token}
    uri.query=URI.encode_www_form(args)
    http=Net::HTTP.new(uri.host,uri.port)
    http.use_ssl=true
    username=''
    name=''
    fb_id=''
    location_name=''
    hometown_name=''
    gender=''
    bio=''
    begin
      request=Net::HTTP::Get.new(uri.request_uri)
      response=http.request(request)

      parsed_data=JSON.parse response.body
      puts parsed_data
      username=parsed_data['username']
      name=parsed_data['name']
      fb_id=parsed_data['id']
      location_name=parsed_data['location']['name']
      hometown_name=parsed_data['hometown']['name']
      gender=parsed_data['gender']
      bio=parsed_data['bio']
    end
    #This token should be used to fetch the user's data
    @user = User.new(params[:user])
    @user.username=username
    @user.name=name
    @user.fb_id=fb_id
    @user.location_name=location_name
    @user.hometown_name=hometown_name
    @user.gender=gender
    @user.bio=bio

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
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
end
