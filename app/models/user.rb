class User < ActiveRecord::Base
  has_many :created_events, class_name: Event, foreign_key: :creator_id
  has_many :managing_events, class_name: Event, through: :event_admins

  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true

end