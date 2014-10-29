class RestaurantController < ApplicationController

	get '/' do
		erb :'index'
	end
end
