class Party < ActiveRecord::Base
	has_many(:orders)
	has_many(:foods, :through => :orders)

	validates :table_number, :number_guests, presence: true
	validates :table_number, uniqueness: true
	validates :table_number, :number_guests, numericality: {only_integer: true }

end
