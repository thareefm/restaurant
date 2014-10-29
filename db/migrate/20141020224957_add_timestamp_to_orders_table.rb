class AddTimestampToOrdersTable < ActiveRecord::Migration
  def change
		add_timestamps(:orders)
  end 
end
