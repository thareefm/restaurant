class FoodsController < ApplicationController


# index: Display a list of food items available
get '/' do
	@foods = Food.all
	erb :'foods/index'
end

# Display a form for a new food item
get '/new' do
	erb :'foods/new'
end

# Creates a new food item
post '/' do
	Food.create(params[:foods])
	new_food = Food.create(params[:foods])
	if new_food.valid?
		redirect "/foods/#{new_food.id}"
	else
		@errors = new_food.errors.full_messages
	erb  :'foods/new'
	end
end

# Display a form to edit a food item
get '/:id/edit' do
	@foods = Food.find(params[:id])
	erb :'foods/edit'
end

# Updates a food item
patch '/:id' do
	@foods = Food.find(params[:id])
	@foods.update(params[:foods])
	redirect "/foods/#{@foods.id}"
end

#Display a single food item and a list of all the parties that included it
get '/:id' do
	@foods = Food.find(params[:id])
	@orders = Order.where(food_id: @foods.id) 
	# @parties = @foods.parties
	erb :'foods/show'
end

# Deletes a food item
delete '/:id' do
	Food.destroy(params[:id])
	redirect '/foods'
end
end
