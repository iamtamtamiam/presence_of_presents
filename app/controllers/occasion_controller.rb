require 'rack-flash'

class OccasionController < ApplicationController
  use Rack::Flash

  get '/occasions' do
    @user = current_user
    @occasions = @user.occasions.all
    erb :'/occasions/index'
  end


  get '/occasions/new' do
    erb :'/occasions/new'
  end

  post '/occasions' do
    if !params[:title].empty?
      @occasion = Occasion.create(title: params[:title], user_id: current_user.id)
      @occasion.save
      redirect "/occasions/#{@occasion.id}"
    else
      redirect "/occasions/new"
    end
  end

  get '/occasions/:id' do
    @occasion = Occasion.find(params[:id])
    erb :'/occasions/show' #showing the wrong title with find_by why???!
  end

  get '/occasions/:id/edit' do
    @occasion = Occasion.find(params[:id])
    if logged_in?
      if @occasion.user == current_user
        erb :'/occasions/edit'
      else
        flash[:message] = "You are not the authorized user to edit this occasion."
        redirect :"occasions/#{@occasion.id}"
        # :"users/#{current_user.id}"
      end
    else
      #if not logged in,
      flash[:message] = "You are not logged in. Please log in."
      redirect "/" ##need to add log in/sign up to home page
      ##need flash message "not logged in"
    end
  end

  patch '/occasions/:id' do
    if logged_in?
      if @occasion = Occasion.find(params[:id]) && !params[:title].empty?
        @occasion.update(title: params[:title])
        redirect "/occasions/#{@occasion.id}"
      else
        #add flash message unsuccessful
        redirect :"occasions/#{@occasion.id}"
      end
      redirect "/"
    end
  end

  delete '/occasions/:id' do
    @occasion = Occasion.find(params[:id])
    if logged_in?
      if @occasion.user == current_user
        @occasion.destroy
        flash[:message] = "Delete Successful!"
        redirect '/occasions'
      else
        flash[:message] = "You are not the authorized user to delete this occasion."
        redirect :"occasions/#{@occasion.id}"
      end
    else
      flash[:message] = "You are not logged in. Please log in."
      redirect "/"
    end
  end

end
