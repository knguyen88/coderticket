class EventAdmin < ActiveRecord::Base
  belongs_to :admin, class_name: User
  belongs_to :event
end
