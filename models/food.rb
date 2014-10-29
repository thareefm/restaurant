class Food < ActiveRecord::Base 
	has_many(:parties, :through => :orders)

	validates :name, uniqueness: true
	validates :name, :price, :cuisine_type, :calories, presence: true
	validates :price, numericality: true

	def price_to_decimal
		sprintf('%0.2f', price)
	end

	def price_to_float
		price.to_f
	end
end