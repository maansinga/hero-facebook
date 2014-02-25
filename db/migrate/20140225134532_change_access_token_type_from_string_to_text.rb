class ChangeAccessTokenTypeFromStringToText < ActiveRecord::Migration
  def up
  	change_column :users,:access_token,:text
  end

  def down
  	change_column :users,:access_token,:string
  end
end
