class Invitee < ActiveRecord::Base
  belongs_to :session
  belongs_to :user
  attr_accessible :host, :user_id
end
