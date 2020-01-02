require 'rack-flash'

class OccasionController < ApplicationController
  use Rack::Flash

  get '/occasions' do
    #may need authentication
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
    set_occasion_by_id
    if logged_in?
      if @occasion.user == current_user
        @occasion_gifts = @occasion.gifts
        erb :'/occasions/show' #showing the wrong title with find_by why???!
      else
        flash[:error] = "You are not the authorized user to view this occasion."
        redirect :"/occasions"
      end
    else
      flash[:error] = "You are not logged in. Please log in."
      redirect "/"
    end
  end

  get '/occasions/:id/edit' do
    set_occasion_by_id
    if logged_in?
      if @occasion.user == current_user
        erb :'/occasions/edit'
      else
        flash[:error] = "You are not the authorized user to edit this occasion."
        redirect :"occasions/#{@occasion.id}"
        # :"users/#{current_user.id}"
      end
    else
      #if not logged in,
      flash[:error] = "You are not logged in. Please log in."
      redirect "/" ##need to add log in/sign up to home page
      ##need flash message "not logged in"
    end
  end

  patch '/occasions/:id' do
    #if logged_in?
      #if @occasion = Occasion.find(params[:id]) && !params[:title].empty?
        #binding.pry
        set_occasion_by_id
        @occasion.update(title: params[:title])
        redirect "/occasions/#{@occasion.id}"
    #  else
        #add flash message unsuccessful
        #redirect :"occasions/#{@occasion.id}"
      #end
      #redirect "/"
    #end
  end

  delete '/occasions/:id' do
    set_occasion_by_id
    if logged_in?
      if @occasion.user == current_user
        @occasion.destroy
        flash[:message] = "Delete Successful!"
        redirect '/occasions'
      else
        flash[:error] = "You are not the authorized user to delete this occasion."
        redirect :"occasions/#{@occasion.id}"
      end
    else
      flash[:error] = "You are not logged in. Please log in."
      redirect "/"
    end
  end

  private

  def set_occasion_by_id
    @occasion = Occasion.find(params[:id])
  end

end
