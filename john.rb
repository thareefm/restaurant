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
	new_food = Food.create(params[:foods])
	if new_food.valid?
		redirect "/foods/#{new_food.id}"
	else
		@errors = new_food.errors.full_messages
	erb  :'foods/new'
	end
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
	@orders = Order.where(food_id: @foods.id) 
	# @parties = @foods.parties
	erb :'foods/show'
end

# Deletes a food item
delete '/foods/:id' do
	Food.destroy(params[:id])
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
	new_party = Party.create(params[:parties])
	if new_party.valid?
		redirect "/parties/#{new_party.id}"
	else
		@errors = new_party.errors.full_messages
		erb  :'parties/new'
	end
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
	@total_price = @parties.orders.inject(0.0) do |acc, order|		
		acc + order.food.price_to_float 
	end
	@tax = (@total_price*0.2).round(2)
	@gratuity = (@total_price*0.15).round(2)
	erb :'parties/show'
end

# Deletes a party
delete '/parties/:id' do
	Party.destroy(params[:id])
	redirect '/parties'
end

# Matt's pry trick
get '/console' do 
	binding.pry
end

#-------------------

# index: Display a list of all current orders
get '/orders' do
	@foods = Food.all
	@orders = Order.all
	erb :'orders/index'
end

# Display a form for a new order
get '/parties/:id/orders/new' do
	@parties = Party.find(params[:id])
	@foods = Food.all
	erb :'orders/new'
end

# Creates a new Order
post '/parties/:id/orders' do
	Order.create(params[:order])
	redirect "/parties/#{params[:id]}/orders"
end


# Deletes a party
delete '/parties/:party_id/orders/:id' do
	Party.find(params[:party_id])
	Order.destroy(params[:id])
	redirect "/parties/#{params[:party_id]}"
end

# Redirects back to 'inspect order' page after creating new order
get '/parties/:id/orders' do
	Party.find(params[:id])
	redirect "/parties/#{params[:id]}"
end

#-------------------

get '/parties/:id/checkout' do
@parties = Party.find(params[:id])
@total_price = @parties.orders.inject(0.0) do |acc, order|		
		acc + order.food.price_to_float 
	end
	@tax = (@total_price*0.2).round(2)
	@gratuity = (@total_price*0.15).round(2)

end

post '/parties/:id/checkout' do
	@parties = Party.find(params[:id])
	@parties.update(pay_status: true)
	@foods = @parties.foods
	 receipt = Receipt.new(@foods, @parties)
  File.open('receipt.txt', 'w+') do |file|
    file << receipt.to_s
  end
  attachment('receipt.txt')
  File.read('receipt.txt')
end

get '/notallowed' do
	erb :notallowed
end












