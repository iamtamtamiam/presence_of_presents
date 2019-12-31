#do i need to add authorization checks?
#do i need a current_occasions methodS

class GiftController < ApplicationController

  get '/gifts' do #do i actually need this method?
    @gifts = Gift.all
    erb :'/gifts/index'
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
      redirect "/gifts/new"
    end

  end


  get '/gifts/:id' do
    @gift = Gift.find(params[:id])
    @occasion = @gift.occasion
    erb :'gifts/show'
  end

  get '/gifts/:id/edit' do
    @gift = Gift.find(params[:id])
    erb :'/gifts/edit'
  end

  patch '/gifts/:id' do #NOT WORKING!!! no update method? no get route?
    #if @gift = Gift.find(params[:id]) && !params[:name].empty?
      @gift = Gift.find(params[:id])
      if !params[:name].empty?
        @gift.update(name: params[:name], giver: params[:giver], category: params[:category], description: params[:description], occasion_id: params[:occasion_id])
        redirect "/gifts/#{@gift.id}"
      else
    #else
      redirect :"/gifts/#{@gift.id}"
      #add flash message
    end
  end

  delete '/gifts/:id' do
    @gift = Gift.find(params[:id])
    @gift.destroy
    #add flash message
    redirect '/gifts'
  end

end
