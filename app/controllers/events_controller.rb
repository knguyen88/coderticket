class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @categories = Category.all
    @venues = Venue.all
    @admins = User.where('id <> ?', current_user.id)
  end

  def my_events
    @events = Event.where()
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
    event_admins = [{admin_id: current_user.id, event_id: new_event.id}]
    params[:event][:admins].each do |user_id|
      event_admins << {admin_id: user_id, event_id: new_event.id}
    end
    EventAdmin.create(event_admins)
  end
end
