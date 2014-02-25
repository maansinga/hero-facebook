class User < ActiveRecord::Base
  attr_accessible :access_token, :username,:name,:gender,:bio,:fb_id,:location_name,:hometown_name
end
