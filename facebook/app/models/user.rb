class User < ActiveRecord::Base
  attr_accessible :access_token, :username
end
