class CreateFoodsTable < ActiveRecord::Migration
  def change
  	create_table :foods do |t|
  		t.string :name
  		t.string :cuisine_type
  		t.integer :calories
  		t.timestamps
  	end
  end
end
