class CreatePartiesTable < ActiveRecord::Migration
  def change
  	create_table :parties do |t|
  		t.integer :table_number
  		t.integer :number_guests
  		t.boolean :pay_status, :default=> false
  		t.integer :order_id
  		t.timestamps
  	end
  end
end
