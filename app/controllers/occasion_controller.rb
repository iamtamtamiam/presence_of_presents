class OccasionController < ApplicationController

  get '/occasions' do
    @occasions = Occasion.all
    erb :'/occasions/index'
  end

  post '/occasions' do
    if !params[:username].empty?
      @occasion = Occasion.create(title: params[:title])
      @occasion.save
      redirect "/occasions/#{@occasion.id}" #need show page
    else
      redirect "/occasions/new"
    end
  end

  get '/occasions/new' do
    erb :'/occasions/new'
  end


end
