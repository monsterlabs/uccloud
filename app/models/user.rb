class User < ActiveRecord::Base
  belongs_to :account
  attr_accessible :custom_access_code, :display_name, :host_privileges, :time_zone, :user_access_code, :user_email
end
