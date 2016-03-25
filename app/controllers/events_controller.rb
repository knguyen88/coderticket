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
  end

  def my_events

  end

  def create
    Event.create(event_params)
    redirect_to(my_events_events_path)
  end

  private
  def event_params
    params.require(:event).permit(:name, :category_id, :description, :hero_image_url, :venue_id, :starts_at, :ends_at)
  end
end
