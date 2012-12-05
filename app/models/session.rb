class Session < ActiveRecord::Base
  belongs_to :account
  belongs_to :host, class_name: User
  has_many :invitees
  has_many :users, :through => :invitees
  attr_accessible :subject, :host_id, :start_datetime, :end_datetime, :host_id, :scheduled_session, :message_body, :ot_session_id

  def now?
    start_datetime <= Time.zone.now
  end
  
  # scope :active, :conditions => "start_datetime <= #{30.minutes.ago}"
end
