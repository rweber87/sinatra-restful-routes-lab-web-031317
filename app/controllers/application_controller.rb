require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#Create
  get '/recipes/new' do 
  	erb :'/new'
  end

  post '/recipes' do 
  	# binding.pry
  	@new_recipe = Recipe.create(params)
  	redirect "/recipes/#{@new_recipe.id}"
  end

  #Read

  get '/recipes' do
  	@recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do 
  	@recipe = Recipe.find(params[:id])
  	erb :show
  end

  #Update

  get '/recipes/:id/edit' do 
  	@recipe = Recipe.find(params[:id])
  	erb :edit
  end

  patch '/recipes/:id' do 
  	@recipe = Recipe.find(params[:id])
  	@recipe.update(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"]) 
  	redirect "/recipes/#{@recipe.id}"
  end

  #Destroy

  delete '/recipes/:id/delete' do
  	@recipe = Recipe.find(params[:id])
  	@recipe.destroy 
  	redirect '/recipes'
  end
end