class OrdersController < ApplicationController

get '/' do
	@foods = Food.all
	@orders = Order.all
	erb :'orders/index'
end

end
