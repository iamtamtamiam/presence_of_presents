class OccasionController < ApplicationController

  get '/occasions' do
    @occasions = Occasion.all
    erb :'/occasions/index'
  end



end
