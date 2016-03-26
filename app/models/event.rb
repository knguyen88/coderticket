class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :creator, class_name: User

  has_many :ticket_types
  has_many :event_admins
  has_many :admins, class_name: User, through: :event_admins

  after_create :add_creator_as_admin

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def published?
    published
  end

  def outdated?
    starts_at < Date.today
  end

  def can_publish?
    !published? && ticket_types.count > 0
  end

  private
  def add_creator_as_admin
    EventAdmin.create({admin_id: creator_id, event_id: id})
  end
end
