class OccasionController < ApplicationController

  get '/occasions' do
    @occasions = Occasion.all
    erb :'/occasions/index'
  end


  get '/occasions/new' do
    erb :'/occasions/new'
  end

  post '/occasions' do
    if !params[:title].empty?
      @occasion = Occasion.create(title: params[:title], user_id: current_user)
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
      ##need flash message "cant edit"
        redirect :"occasions/#{@occasion.id}"
      end
    else
      #if not logged in,
      redirect "/" ##need to add log in/sign up to home page
      ##need flash message "not logged in"
    end
  end

  patch '/occasions/:id' do
      @occasion = Occasion.find(params[:id])
      @occasion.update(title: params[:title])
      redirect "/occasions/#{@occasion.id}"
  end

  delete '/occasions/:id' do
    @occasion = Occasion.find(params[:id])
    if logged_in?
      if @occasion.user == current_user
        @occasion.destroy
        redirect '/occasions'
      else
        ##need flash message "cant delete"
        redirect :"occasions/#{@occasion.id}"
      end
    else
      redirect "/"
    end
  end

end
