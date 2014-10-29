class ApplicationController < Sinatra::Base
	ActiveRecord::Base.establish_connection(
		adapter: "postgresql",
		database: "restaurant_db"
		)

	set :views, File.expand_path('../../views', __FILE__)
	set :public, File.expand_path('../../public', __FILE__)

	enable :sessions, :method_overide

	get '/' do
		redirect '/restaurants'
	end

end
