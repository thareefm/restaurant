class AddColumnPriceToFoods < ActiveRecord::Migration
  def change
  	add_column :foods, :price, :money
  end
end
