require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection({
	adapter: 'postgresql',
	database: 'restaurant-db'
	})

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }

get '/' do
	"hello"
end