require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #need to authenticate password
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    #redirect to show page (users/:id)
    else
      flash[:error] = "Login Unsuccessful! Please make sure username/password are correct."
      redirect "/login"
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/users' do
    @user = User.new(:username => params[:username], :password => params[:password])
    #if !params[:username].empty? && !params[:password].empty? #doesnt know where to redirect bc unique would be false
    if @user.save
      #@user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id #actually logging them in
      redirect "/users/#{@user.id}"
    else
      flash[:error] = "Signup Unsuccessful! Please make sure to enter a username and password. or, Username may already be taken. Please try another username."
      redirect "/signup"
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
