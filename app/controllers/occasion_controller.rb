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

  get "/occasions/:id/edit" do
    @occasion = Occasion.find(params[:id])
    erb :'/occasions/edit'
  end

end
