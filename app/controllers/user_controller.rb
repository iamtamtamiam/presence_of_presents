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
      flash[:message] = "Login Unsuccessful! Please make sure username/password are correct."
      redirect "/login"
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/users' do
    if !params[:username].empty? && !params[:password].empty?
      @user = User.create(:username => params[:username], :password => params[:password])
      @user.save #do i need to save?
      session[:user_id] = @user.id #actually logging them in
      redirect "/users/#{@user.id}"
    else
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
