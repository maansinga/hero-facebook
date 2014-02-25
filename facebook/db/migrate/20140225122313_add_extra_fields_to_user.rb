class AddExtraFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users,:name,:string
  	add_column :users,:fb_id,:string
  	add_column :users,:location_name,:string
  	add_column :users,:hometown_name,:string
  	add_column :users,:gender,:string
  	add_column :users,:bio,:string
  end
end
