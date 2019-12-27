
class GiftController < ApplicationController

  get '/gifts' do
    @gifts = Gift.all
    erb :'gifts/index'
  end

  get '/gifts/new' do
    erb :'/gifts/new'
  end

  post '/gifts' do
    #@gift = Gift.create(name: params[:name], giver: params[:giver], category: params[:category], description: params[:description], occasion_id: current_user.id)
    if !params[:name].empty?
      @gift = Gift.create(params)
      @gift.save
      redirect "/gifts/#{@gift.id}"
    else
      redirect "/occasions/new"
    end

  end


  get '/gifts/:id' do
    @gift = Gift.find(params[:id])
    erb :'gifts/show'
  end


end
