require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection({
	adapter: 'postgresql',
	database: 'restaurant_db'
	})

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }

get '/' do
	redirect '/restaurants'
end	

get '/restaurants' do
	erb :'index'
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

#-------------------

# index: Display a list of parties available
get '/parties' do
	@parties = Party.all
	erb :'/parties/index'
end

# Display a form for a new party
get '/parties/new' do
	erb :'parties/new'
end

# Creates a new Party
post '/parties' do
	Party.create(params[:parties])
	redirect '/parties'
end

# Display a form to edit a party
get '/parties/:id/edit' do
	@parties = Party.find(params[:id])
	erb :'parties/edit'
end

# Updates a food item
patch '/parties/:id' do
	@parties = Party.find(params[:id])
	@parties.update(params[:parties])
	redirect "/parties/#{@parties.id}"
end

#Display a single party and a list of all the orders
get '/parties/:id' do
	@parties = Party.find(params[:id])
	# @parties = @foods.parties
	erb :'parties/show'
end


