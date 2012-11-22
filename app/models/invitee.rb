class Invitee < ActiveRecord::Base
  belongs_to :session
  # attr_accessible :title, :body
end
