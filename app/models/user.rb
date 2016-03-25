class User < ActiveRecord::Base
  has_many :created_events, class_name: Event, foreign_key: :creator_id
  has_many :managing_events, class_name: Event, through: :event_admins, source: :event
  has_many :event_admins, foreign_key: :admin_id

  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true

end