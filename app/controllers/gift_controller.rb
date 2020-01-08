require 'rack-flash'
class GiftController < ApplicationController

use Rack::Flash

  get '/gifts' do
    @user_occasions = current_user.occasions
    erb :'/gifts/index'
  end

  get '/gifts/new' do
    redirect_if_not_logged_in
    erb :'/gifts/new'
  end

  post '/gifts' do
    if !params[:name].empty?
      @gift = Gift.create(params)
      @gift.save
      redirect "/gifts/#{@gift.id}"
    else
      redirect "/gifts/new"
    end
  end


  get '/gifts/:id' do
    #set_gift_by_id
    redirect_if_object_does_not_exist(method(:set_gift_by_id))
    redirect_if_not_logged_in #so they cant manipulate url
      if authorized_to_edit_gift?(@gift)
        @occasion = @gift.occasion
        erb :'gifts/show'
      else
        flash[:error] = "You are not the authorized user to view this gift. Returning to your homepage."
        redirect "/users/#{current_user.id}"
      end
  end

  get '/gifts/:id/edit' do
    set_gift_by_id
    redirect_if_not_logged_in
      if authorized_to_edit_gift?(@gift)
        erb :'/gifts/edit'
      else
        flash[:error] = "You are not the authorized user to edit this gift."
        redirect "/gifts/#{@gift.id}"
      end
  end

  patch '/gifts/:id' do
      set_gift_by_id
      if !params[:name].empty?
        @gift.update(name: params[:name], giver: params[:giver], category: params[:category], description: params[:description], occasion_id: params[:occasion_id])
        redirect "/gifts/#{@gift.id}"
      else

        flash[:error] = "Gift Name cannot be blank."
        redirect :"/gifts/#{@gift.id}"

    end
  end

  delete '/gifts/:id' do
    set_gift_by_id
    redirect_if_not_logged_in
    if authorized_to_edit_gift?(@gift)
      @gift.destroy
      flash[:message] = "Delete Successful!"
      redirect '/occasions'
    else
      flash[:error] = "You are not the authorized user to delete this gift."
      redirect :"/gifts/#{@gift.id}"
    end
  end

  private

  def set_gift_by_id
    @gift = Gift.find(params[:id])
  end

  def authorized_to_edit_gift?(gift_v)
    gift_v.occasion.user == current_user
  end

end
