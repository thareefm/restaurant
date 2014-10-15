class Party < ActiveRecord::Base
	has_many(:foods, :through => :orders)
end
