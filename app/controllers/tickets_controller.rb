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

  def buy
    @event = Event.find(params[:event_id])
    if @event.outdated?
      flash[:error] = 'This event has expired. You cannot buy its ticket'
      redirect_to(event_path(event))
    else
      prepare_order
      flash[:success] = 'You have purchased tickets successfully. Below is your order.'
      render('tickets/buy')
    end
  end

  private
  def ticket_params
    params
        .require(:ticket)
        .permit(:name, :price, :max_quantity, :min_quantity)
  end

  def prepare_order
    @orders = []
    ticket_types = TicketType.where(id: params[:tickets].keys)
    ticket_types.each do |type|
      @orders.push({ticket_type: type, quantity: params[:tickets][type.id.to_s].to_i})
    end
    @total = @orders.inject(0) do |total, order|
      total + order[:ticket_type].price * order[:quantity]
    end
  end
end
