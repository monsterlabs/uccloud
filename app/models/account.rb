class Account < ActiveRecord::Base
  attr_accessible :admin_email, :description, :disabled, :name
end
