class PartiesController < ApplicationController
	# index: Display a list of parties available
get '/' do
	@parties = Party.all
	erb :'/parties/index'
end

# Display a form for a new party
get '/new' do
	erb :'parties/new'
end

# Creates a new Party
post '/' do
	new_party = Party.create(params[:parties])
	if new_party.valid?
		redirect "/parties/#{new_party.id}"
	else
		@errors = new_party.errors.full_messages
		erb  :'parties/new'
	end
end

# Display a form to edit a party
get '/:id/edit' do
	@parties = Party.find(params[:id])
	erb :'parties/edit'
end

# Updates a food item
patch '/:id' do
	@parties = Party.find(params[:id])
	@parties.update(params[:parties])
	redirect "/parties/#{@parties.id}"
end

#Display a single party and a list of all the orders
get '/:id' do
	@parties = Party.find(params[:id])
	@total_price = @parties.orders.inject(0.0) do |acc, order|		
		acc + order.food.price_to_float 
	end
	@tax = (@total_price*0.2).round(2)
	@gratuity = (@total_price*0.15).round(2)
	erb :'parties/show'
end

# Deletes a party
delete '/:id' do
	Party.destroy(params[:id])
	redirect '/'
end

get '/:id/orders/new' do
	@parties = Party.find(params[:id])
	@foods = Food.all
	erb :'orders/new'
end

post '/:id/orders' do
	Order.create(params[:order])
	redirect "/parties/#{params[:id]}/orders"
end


# Deletes a party
delete '/:party_id/orders/:id' do
	Party.find(params[:party_id])
	Order.destroy(params[:id])
	redirect "/parties/#{params[:party_id]}"
end

# Redirects back to 'inspect order' page after creating new order
get '/:id/orders' do
	Party.find(params[:id])
	redirect "/parties/#{params[:id]}"
end

get '/:id/checkout' do
@parties = Party.find(params[:id])
@total_price = @parties.orders.inject(0.0) do |acc, order|		
		acc + order.food.price_to_float 
	end
	@tax = (@total_price*0.2).round(2)
	@gratuity = (@total_price*0.15).round(2)

end

post '/:id/checkout' do
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

end
