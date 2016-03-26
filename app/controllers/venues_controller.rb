class VenuesController < ApplicationController

  before_action :require_login

  def show_venues_list
    @venues = Venue.all
  end

  def show_new_venue_form
    @regions = Region.all
    render 'new'
  end

  def create_new_venue
    Venue.create(venue_params)
    redirect_to venues_path
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end
end