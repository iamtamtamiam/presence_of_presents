require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if logged_in?
        redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end


  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_logged_in
    if !logged_in?
      flash[:error] = "You are not logged in. Please log in."
      redirect '/'
    end
  end

  def redirect_if_object_does_not_exist
    if ActiveRecord::RecordNotFound
        flash[:error] = "You are not authorized to view this page."
        redirect '/'
    end
  end

  def redirect_if_object_does_not_exist(defined)
    begin
      defined.call
      #set_occasion_by_id
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "You are not the authorized user to view that page. Redirected to your home page."
      redirect '/'#render(:partial => 'date_not_found', :layout => 'application', :status => :not_found)
    end
  end


end
