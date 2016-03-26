class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    ticket_type = TicketType.new(ticket_params)
    ticket_type.event = Event.find(params[:event_id])
    ticket_type.save

    redirect_to(edit_event_path(params[:event_id]))
  end

  private
  def ticket_params
    params
        .require(:ticket)
        .permit(:name, :price, :max_quantity, :min_quantity)
  end
end
