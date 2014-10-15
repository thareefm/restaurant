require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection({
	adapter: 'postgresql',
	database: 'restaurant_db'
	})

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }

get '/' do
	redirect '/foods'
end	


# index: Display a list of food items available
get '/foods' do
	@foods = Food.all
	erb :'foods/index'
end

# Display a form for a new food item
get '/foods/new' do
	erb :'foods/new'
end

# Creates a new food item
post '/foods' do
	Food.create(params[:foods])
	redirect '/foods'
end

# Display a form to edit a food item
get '/foods/:id/edit' do
	@foods = Food.find(params[:id])
	erb :'foods/edit'
end

# Updates a food item
patch '/foods/:id' do
	@foods = Food.find(params[:id])
	@foods.update(params[:foods])
	redirect "/foods/#{@foods.id}"
end

#Display a single food item and a list of all the parties that included it
get '/foods/:id' do
	@foods = Food.find(params[:id])
	# @parties = @foods.parties
	erb :'foods/show'
end

# Deletes a food item
delete '/foods/:id' do
	Food.delete(params[:id])
	redirect '/foods'
end





