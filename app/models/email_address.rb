class EmailAddress < ActiveRecord::Base
  belongs_to :user
  attr_accessible :email, :primary
end
