
class GiftController < ApplicationController

  get '/gifts' do
    @gifts = Gift.all
    erb :'gifts/index'
  end


  get '/gifts/:id' do
    @gift = Gift.find(params[:id])
    erb :'gifts/show'
  end


end
