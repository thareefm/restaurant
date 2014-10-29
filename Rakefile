require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'
require_relative 'connection.rb'

namespace :db do
	desc "Create restaurant_database database"
	task :create_db do
		conn = PG::Connection.open()
		conn.exec('CREATE DATABASE restaurant_db;')
		conn.close
	end

	desc "Drop restaurant_db database"
	task :drop_db do
		conn = PG::Connection.open()
		conn.exec('DROP DATABASE restaurant_db;')
		conn.close
	end

	desc "create junk data for development"
	task :junk_data do

		require_relative 'connection'
    require_relative 'models/food'
    require_relative 'models/party'
    require_relative 'models/order'

    Food.create({name: 'Mac & Cheese', cuisine_type: "Home", calories: 200, price: 8.25})
    Food.create({name: 'Steak', cuisine_type: "Meat", calories: 250, price: 5.95})
    Food.create({name: 'Kale Salad', cuisine_type: "Greens", calories: 375, price: 3.75})
    Food.create({name: 'Chicken Noodle Soup', cuisine_type: "Home", calories: 185, price: 12.5})
    Food.create({name: 'Old Fashioned', cuisine_type: "Drink", calories: 245, price: 750})
    Food.create({name: 'Fizzy Water', cuisine_type: "Drink", calories: 385, price: 3.50})

    Party.create({table_number: 4,  number_guests: 3})
    Party.create({table_number: 9,  number_guests: 2})
    Party.create({table_number: 12, number_guests: 4})
    Party.create({table_number: 13, number_guests: 7})
    Party.create({table_number: 6,  number_guests: 2})
    Party.create({table_number: 11, number_guests: 3})
    Party.create({table_number: 18, number_guests: 1})

    parties = Party.all
    foods = Food.all

    parties.each do |party|
      party.number_guests.times do
        Order.create({party: party, food: foods.sample}) if [true, false].sample
      end
    end
  end
end
