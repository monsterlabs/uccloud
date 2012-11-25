require Rails.root.join('lib', 'devise', 'encryptors', 'plain')

class User < ActiveRecord::Base
  belongs_to :account
  attr_accessible :custom_access_code, :display_name, :host_privileges, :time_zone, :user_access_code, :email

  devise :database_authenticatable, :registerable,:encryptable, :encryptor => :plain

  validates_uniqueness_of :email
  validates_uniqueness_of :user_access_code

  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_presence_of :user_access_code, :on => :create, :message => "can't be blank"

  before_validation(:on => :create) do
    self.user_access_code = "555-555-" + ("%04d" % User.count) # TODO only 10000 users for prototype
  end

  def encrypted_password
    user_access_code
  end

  def encrypted_password=(pass)
     user_access_code = pass
  end

  def password
     user_access_code
  end

  def password=(pass)
     user_access_code = pass
  end

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end
end
