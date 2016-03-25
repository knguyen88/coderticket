class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @related_events = Event.joins(:category).joins(:venue).joins('inner join regions on regions.id = venues.region_id')
                          .where('regions.id = ? and categories.id = ?', @event.venue.region_id, @event.category.id)
  end

  def new
    @categories = Category.all
    @venues = Venue.all
    @admins = User.where('id <> ?', current_user.id)
  end

  def my_events
    @events = current_user.managing_events
  end

  def create
    create_new_event
    redirect_to(my_events_events_path)
  end

  private
  def event_params
    params
        .require(:event)
        .permit(:name, :category_id, :extended_html_description, :hero_image_url, :venue_id, :starts_at, :ends_at, :creator_id)
        .merge(:creator_id => current_user.id)
  end

  def create_new_event
    new_event = Event.create(event_params)
    event_admins = []
    params[:event][:admins].try(:each) do |user_id|
      event_admins << {admin_id: user_id, event_id: new_event.id}
    end
    EventAdmin.create(event_admins)
  end
end
