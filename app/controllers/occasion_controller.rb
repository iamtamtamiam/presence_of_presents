
class OccasionController < ApplicationController
  use Rack::Flash

  get '/occasions' do
    @user = current_user
    @occasions = @user.occasions.all
    erb :'/occasions/index'
  end


  get '/occasions/new' do
    redirect_if_not_logged_in
    erb :'/occasions/new'
  end

  post '/occasions' do
    if !params[:title].empty?
      @occasion = Occasion.create(title: params[:title], user_id: current_user.id)
      @occasion.save
      redirect "/occasions/#{@occasion.id}"
    else
      flash[:error] = "Occasion Title cannot be blank."
      redirect "/occasions/new"
    end
  end

  get '/occasions/:id' do
    redirect_if_object_does_not_exist(method(:set_occasion_by_id))
    #set_occasion_by_id
    #redirect_if_object_does_not_exist
    redirect_if_not_logged_in
      if authorized_to_edit_occasion?(@occasion)
        @occasion_gifts = @occasion.gifts
        erb :'/occasions/show'
      else
        flash[:error] = "You are not the authorized user to view this occasion."
        redirect :"/occasions"
      end
  end

  get '/occasions/:id/edit' do
    set_occasion_by_id
    redirect_if_not_logged_in
      if authorized_to_edit_occasion?(@occasion)
        erb :'/occasions/edit'
      else
        flash[:error] = "You are not the authorized user to edit this occasion."
        redirect :"occasions/#{@occasion.id}"

      end
  end

  patch '/occasions/:id' do
        set_occasion_by_id
        if !params[:title].empty?
          @occasion.update(title: params[:title])
          redirect "/occasions/#{@occasion.id}"
        else
          flash[:error] = "Occasion Title cannot be blank."
          redirect :"occasions/#{@occasion.id}"
        end
  end

  delete '/occasions/:id' do
    set_occasion_by_id
    redirect_if_not_logged_in
      if authorized_to_edit_occasion?(@occasion)
        @occasion.gifts.destroy_all
        @occasion.destroy
        flash[:message] = "Delete Successful!"
        redirect '/occasions'
      else
        flash[:error] = "You are not the authorized user to delete this occasion."
        redirect :"occasions/#{@occasion.id}"
      end
  end

  private

  def set_occasion_by_id
    @occasion = Occasion.find(params[:id])
  end

  def authorized_to_edit_occasion?(occasion_v) #view and edit
    occasion_v.user == current_user
  end

end
