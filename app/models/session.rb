class Session < ActiveRecord::Base
  belongs_to :account
  attr_accessible :end_datetime, :host_id, :scheduled_session, :start_datetime
end
