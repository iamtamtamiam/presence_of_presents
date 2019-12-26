class UserController < ApplicationController

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
      redirect "/login"
    end
  end


  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'users/show'
  end

end
