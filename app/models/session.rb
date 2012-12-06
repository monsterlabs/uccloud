class Session < ActiveRecord::Base
  belongs_to :account
  belongs_to :host, class_name: User
  has_many :invitees
  has_many :users, :through => :invitees
  attr_accessible :subject, :host_id, :start_datetime, :end_datetime, :host_id, :scheduled_session, :message_body, :ot_session_id

  def now?
    start_datetime <= Time.zone.now
  end

  scope :scheduled, conditions: {scheduled_session: true}
  scope :on_demand, conditions: {scheduled_session: false}

  scope :active, (lambda do
    now = Time.now.utc
    for_on_demand = "(scheduled_session = 'f' AND start_datetime >= ?)"
    for_scheduled = "(scheduled_session = 't' AND start_datetime <= ? AND end_datetime >= ?)"
    {conditions: ["#{for_on_demand} OR #{for_scheduled}", now - 3.hours, now + 30.minutes, now - 1.hour], order: :start_datetime}
  end)

end
