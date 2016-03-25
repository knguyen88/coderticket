class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :creator, class_name: User

  has_many :ticket_types
  has_many :event_admins
  has_many :admins, class_name: User, through: :event_admins

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
end
