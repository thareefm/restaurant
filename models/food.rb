class Food < ActiveRecord::Base
	has_many(:parties, :through => :orders)
	
end
