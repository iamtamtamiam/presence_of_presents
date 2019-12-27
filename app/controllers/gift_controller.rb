
class GiftController < ApplicationController

  get '/gifts' do
    @gifts = Gift.all
    erb :'gifts/index'
  end





end
