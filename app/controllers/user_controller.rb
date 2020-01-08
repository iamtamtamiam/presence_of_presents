

class UserController < ApplicationController
  use Rack::Flash

  get '/login' do
    if logged_in?
      flash[:error] = "You are already logged in. If you wish to log out, click 'Logout' below."
      redirect "/users/#{current_user.id}"
    else
      erb :login
    end
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
    if logged_in?
      flash[:error] = "You are already logged in. If you wish to log out, click 'Logout' below."
      redirect "/users/#{current_user.id}"
    else
      erb :signup
    end
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
    redirect_if_object_does_not_exist(method(:set_user_by_id))
    #@user = User.find(params[:id])
    if @user == current_user
      erb :'users/show'
    else
      flash[:error] = "You are not the authorized to view another user."
      redirect "/"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  private

  def set_user_by_id
    @user = User.find(params[:id])
  end

end
