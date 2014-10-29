require 'bundler'
Bundler.require(:default)
Dir.glob('./{helpers,models,controllers}/*.rb').
each do |file|
	require file
	puts "required #{file}"
end

map('/'){run ApplicationController}
map('/restaurants'){run RestaurantController}
map('/foods'){run FoodsController}
map('/parties'){run PartiesController}
map('/orders'){run OrdersController}
