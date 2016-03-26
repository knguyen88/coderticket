class EventsController < ApplicationController
  include EventsHelper

  before_action :load_data_for_event_form, only: [:new, :edit]

  def index
    @events = Event.where('starts_at >= ? and published = true', Date.today)
  end

  def show
    @event = Event.find(params[:id])
    @related_events = Event.joins(:category).joins(:venue).joins('inner join regions on regions.id = venues.region_id')
                          .where('events.id <> ? and regions.id = ? and categories.id = ?', @event.id, @event.venue.region_id, @event.category.id)
  end

  def new
    @event = Event.new(hero_image_url: 'https://az810747.vo.msecnd.net/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter')
  end

  def my_events
    @events = current_user.managing_events
  end

  def create
    create_new_event
    redirect_to(my_events_events_path)
  end

  def edit
    @event = Event.find(params[:id])
    redirect_to(my_events_events_path) unless can_edit?(@event)
  end

  def update
    update_event
    redirect_to event_path(params[:id])
  end

  def publish
    @event = Event.find(params[:id])
    if can_edit?(@event)
      if params[:event][:publish] == 'true'
        if @event.can_publish?
          @event.published = true
          @event.save
          flash[:success] = 'Your event has been published'
        else
          flash[:error] = 'Your event needs at least 1 ticket type before it can be published'
        end
      elsif params[:event][:publish] == 'false'
        @event.published = false
        @event.save
        flash[:success] = 'Your event has been unpublished'
      end
      redirect_to(edit_event_path(@event))
    else
      flash[:error] = 'You do not have permission to edit this event'
      redirect_to(event_path(@event))
    end
  end

  private
  def event_params
    params
        .require(:event)
        .permit(:name, :category_id, :extended_html_description, :hero_image_url, :venue_id, :starts_at, :ends_at, :creator_id)
  end

  def create_new_event
    new_event = Event.create(event_params.merge(:creator_id => current_user.id))
    create_event_admins(new_event)
    new_event
  end

  def update_event
    event = Event.find(params[:id])
    event.update(event_params)
    remove_event_admins(event)
    create_event_admins(event)
  end

  def create_event_admins(event)
    event_admins = []
    params[:event][:admins].try(:each) do |user_id|
      event_admins << {admin_id: user_id, event_id: event.id}
    end
    EventAdmin.create(event_admins)
  end

  def remove_event_admins(event)
    EventAdmin.where('event_id = ? and admin_id <> ?', event.id, event.creator_id).delete_all
  end

  def load_data_for_event_form
    @categories = Category.all
    @venues = Venue.all
    @admins = User.where('id <> ?', current_user.id)
  end
end
